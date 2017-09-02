package models

case class UserSmpTabModel
(
  smplId: Int,
  userId: Int,
  tabFieldFilterTabId: Int,
  tabFieldFilterFieldId: Int,
  tabFieldFilterFilterId: Int,
  value: String
)
