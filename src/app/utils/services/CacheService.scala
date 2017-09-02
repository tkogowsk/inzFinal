package utils.services

import play.api.cache.CacheApi
import javax.inject.Inject

import play.api.libs.json.{JsObject, Json}
import repository.JDBCRepository

import scala.concurrent.duration._

class CacheService @Inject()(cache: CacheApi, controllersCommon: ControllersCommon, jdbcRepository: JDBCRepository){

  def getTranscriptData(sampleId: String) = {
    val key = sampleId + "transcriptDataCache"
    val cacheVal = cache.get[JsObject](key)
    if (cacheVal.isEmpty) {
      val transcriptData = jdbcRepository.getBySampleId(sampleId)
      val resp = controllersCommon.successResponse(Json.toJson(transcriptData), "list of  transcripts")
      cache.set(key, resp, 1.day)
      resp
    } else {
      cacheVal.get
    }
  }

}
