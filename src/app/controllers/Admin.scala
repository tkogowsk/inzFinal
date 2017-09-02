package controllers

import javax.inject.Inject

import akka.actor.ActorSystem
import play.api.libs.json.Json
import utils.JsonFormat._
import play.api.mvc.Controller
import repository._
import utils.security.Secured
import utils.services.ControllersCommon

import scala.concurrent.Await
import scala.concurrent.duration.Duration
import scala.concurrent.ExecutionContext.Implicits.global

class Admin @Inject()(webJarAssets: WebJarAssets, variantColumnRepository: VariantColumnRepository, controllersCommon: ControllersCommon,
                            tabFieldFilterRepository: TabFieldFilterRepository, jdbcRepository: JDBCRepository, system: ActorSystem) extends Controller with Secured {
  
  def getUsersList = withAdmin { user =>
    request =>
      Await.result(
        UserRepository.getAll.map {
          list =>
            Ok(controllersCommon.successResponse(Json.toJson(list), "list of users"))
        }, Duration.Inf)
  }

  def getSamplesIds(userId: Int) = withAdmin { user =>
    request =>
      val list = jdbcRepository.getAllIds
      Ok(controllersCommon.successResponse(Json.toJson(list), "list of samples"))
  }

  def getSamplesList() = withAdmin { user =>
    request =>
      Await.result(
        SampleMetadataRepository.getAll().map {
          list =>
            Ok(controllersCommon.successResponse(Json.toJson(list), "list of samples"))
        }, Duration.Inf)
  }


  def getUserPrivilegesList(userId: Int) = withAdmin { user =>
    request =>
      Await.result(
        PrivilegeRepository.getAll(userId).map {
          list =>
            Ok(controllersCommon.successResponse(Json.toJson(list), "list of available samples"))
        }, Duration.Inf)
  }

  def setUserPrivilegesList(userId: Int) = withAdmin { user =>
    request =>
      request.body.asJson.map {
        json =>
          json.asOpt[List[Int]].map {
            elem =>
              PrivilegeRepository.save(userId, elem)
              Ok("success")
          }.getOrElse {
            BadRequest("Missing parameter")
          }
      }.getOrElse {
        BadRequest("Expecting Json data")
      }
  }
}
