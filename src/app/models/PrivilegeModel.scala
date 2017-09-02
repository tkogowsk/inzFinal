package models

case class PrivilegeModel
(
  userId: Int,
  smplId: Int,
  access_type: Option[String],
  region_id: Option[Int]
)