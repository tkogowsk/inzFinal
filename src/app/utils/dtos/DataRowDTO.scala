package utils.dtos

import play.api.libs.json.Json

import scala.collection.mutable.ListBuffer

case class DataRowDTO
(
  r: ListBuffer[DataCellDTO]
)

object DataRowDTO {
  implicit val format = Json.format[DataRowDTO]
}