package utils


object Relation extends Enumeration {
  val Equals = "="
  val Greater = ">"
  val Less = "<"
  val GreaterThan = ">="
  val LessThan = "<="

  def toSqlValue(value: String): String = value.toUpperCase match {
    case "EQUALS" =>
      Equals
    case "GREATER" =>
      Greater
    case "LESS" =>
      Less
    case "GREATER THAN" =>
      GreaterThan
    case "LESS THAN" =>
      LessThan
    case _ =>
      throw new IllegalArgumentException
  }

}
