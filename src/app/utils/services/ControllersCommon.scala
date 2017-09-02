package utils.services

import play.api.libs.json.JsValue
import play.api.libs.json.Json.obj
import utils.Constants

class ControllersCommon {

  def successResponse(data: JsValue, message: String) = {
    obj("status" -> Constants.SUCCESS, "data" -> data, "msg" -> message)
  }

}
