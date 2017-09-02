package utils.dtos

import play.api.libs.json.Json

case class DataCellDTO
(
  id: Int,
  v: String
)

object DataCellDTO {
  implicit val format = Json.format[DataCellDTO]
}