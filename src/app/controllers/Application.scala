package controllers

import java.util.Calendar
import javax.inject.Inject

import akka.actor.ActorSystem
import play.api.libs.json.Json
import play.api.mvc._
import repository._
import utils.JsonFormat._
import utils.dtos._
import utils.security.Secured
import utils.services.{CacheService, ControllersCommon}

import scala.concurrent.Await
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration._

class Application @Inject()(webJarAssets: WebJarAssets, controllersCommon: ControllersCommon, variantColumnRepository: VariantColumnRepository,
                            tabFieldFilterRepository: TabFieldFilterRepository, jdbcRepository: JDBCRepository, system: ActorSystem, cacheService: CacheService) extends Controller with Secured {

  def index = Action {
    Ok(views.html.index(webJarAssets))
  }

  def angular(any: Any) = index
  
  def getFields(sampleFakeId: Int) = withUser { user =>
    request =>
      Await.result(
        SampleMetadataRepository.getByFakeId(sampleFakeId).map {
          sample =>
            if (sample.isDefined) {
              Await.result(
                tabFieldFilterRepository.getFilter(sample.get.fakeId, user.id).map { res =>
                  val list = res.map(item => TabFieldFilterDTO(item._1, item._2, item._3, item._4, item._5, item._6, item._7, item._8, item._9, item._10, item._11))
                  Ok(controllersCommon.successResponse(Json.toJson(list), "Getting Variant column list successfully"))
                }, Duration.Inf)
            } else {
              BadRequest("Not found sample id")
            }
        }, Duration.Inf)
  }

  def getVariantColumn: Action[AnyContent] = Action.async { request =>
    variantColumnRepository.getAll.map { res =>
      Ok(controllersCommon.successResponse(Json.toJson(res), "Getting Variant column list successfully"))
    }
  }

  def getTranscriptData(sampleFakeId: Int) = withUser { user =>
    request =>
      val privilegeModel = PrivilegeRepository.getPrivilege(user.id, sampleFakeId)
      if (privilegeModel.isDefined) {
        Await.result(
          SampleMetadataRepository.getByFakeId(sampleFakeId).map {
            sample =>
              if (sample.isDefined) {
                val response = cacheService.getTranscriptData(sample.get.sampleId)
                Ok(response)
              } else {
                BadRequest("Not found sample id")
              }
          }, Duration.Inf)
      } else {
        BadRequest("Not allowed")
      }
  }

  def getByTab = withUser { user =>
    request =>
      var sampleId = None: Option[String]
      request.body.asJson.map { json =>
        json.asOpt[FilterDTO].map { elem =>
          Await.result(
            SampleMetadataRepository.getByFakeId(elem.sampleFakeId).map {
              sample =>
                if (sample.isDefined) {
                  sampleId = Some(sample.get.sampleId)
                } else {
                  BadRequest("Sample not found")
                }
            }, Duration.Inf)

          val res = jdbcRepository.getByFields(elem, sampleId.get)
          Ok(controllersCommon.successResponse(Json.toJson(res), "data from jdbc fetched"))
        }.getOrElse {
          BadRequest("Missing parameter")
        }
      }.getOrElse {
        BadRequest("Expecting Json data")
      }

  }

  def getUserSamplesList = withUser { user =>
    _ => {
      Await.result(
        PrivilegeRepository.getAllUserSamples(user).map {
          list =>
            Ok(controllersCommon.successResponse(Json.toJson(list), "list of available samples"))
        }, Duration.Inf)
    }
  }

  def count = withUser { user =>
    request =>
      request.body.asJson.map {
        json =>
          json.asOpt[FilteringCountersDTO].map {
            elem =>
              val res = jdbcRepository.count(elem)
              Ok(controllersCommon.successResponse(Json.toJson(res), ""))
          }.getOrElse {
            BadRequest("Missing parameter")
          }
      }.getOrElse {
        BadRequest("Expecting Json data")
      }
  }

  def saveUserFields() = withUser { user =>
    request =>
      request.body.asJson.map {
        json =>
          json.asOpt[List[UserSampleTabDTO]].map {
            elem =>
              UserSmpTabRepository.save(user.id, elem)
              Ok(controllersCommon.successResponse(Json.toJson(""), "Fields saved"))
          }.getOrElse {
            BadRequest("Missing parameter")
          }
      }.getOrElse {
        BadRequest("Expecting Json data")
      }
  }

  def getVisibleColumns = withUser { user =>
    request =>
      Await.result({
        UserVisibleVariantColumnRepository.get(user.id).map { list =>
          Ok(controllersCommon.successResponse(Json.toJson(list), "list of visible columns"))
        }
      }, Duration.Inf)
  }

  def saveVisibleColumns = withUser { user =>
    request =>
      request.body.asJson.map {
        json =>
          json.asOpt[List[VisibleColumnDTO]].map { list =>
            UserVisibleVariantColumnRepository.save(user.id, list)
            Ok(controllersCommon.successResponse(Json.toJson(""), "Visible columns saved"))
          }.getOrElse {
            BadRequest("Missing parameter")
          }
      }.getOrElse {
        BadRequest("Expecting Json data")
      }
  }

}