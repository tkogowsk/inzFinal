package repository

import models.{PrivilegeModel, SampleMetadataModel, UserModel}
import utils.MyPostgresDriver.api._

import scala.concurrent.{Await, Future}
import scala.concurrent.duration.Duration
import scala.concurrent.ExecutionContext.Implicits.global

object PrivilegeRepository {
  private val db = Database.forConfig("postgresConf")

  var privilege = TableQuery[PrivilegeTableRepository]
  var sampleMetadata = SampleMetadataRepository.sampleMetadata

  class PrivilegeTableRepository(tag: Tag) extends Table[PrivilegeModel](tag, "privilege") {

    def userId = column[Int]("user_id", O.PrimaryKey)

    def smplId = column[Int]("sample_metadata_id", O.PrimaryKey)

    def access_type = column[Option[String]]("access_type")

    def region_id = column[Option[Int]]("region_id", O.PrimaryKey)

    def * = (userId, smplId, access_type, region_id) <> (PrivilegeModel.tupled, PrivilegeModel.unapply)

  }

  def getAll(): Future[List[PrivilegeModel]] = db.run {
    privilege.to[List].result
  }

  def getAllUserSamples(user: UserModel): Future[Seq[SampleMetadataModel]] = {
    val query = for {
      (a, b) <- sampleMetadata join privilege on ((j, h) => j.fakeId === h.smplId && h.userId === user.id)
    } yield a
    val result = query.result
    db.run(result)
  }

  def getAll(userId: Int): Future[Seq[(String)]] = {
    val query = for {
      (smplTable, privTable) <- sampleMetadata join privilege on ((smplRow, privRow) => smplRow.fakeId === privRow.smplId && privRow.userId === userId)
    } yield smplTable.sampleId
    val result = query.result
    db.run(result)
  }

  def getPrivilege(userId: Int, sampleFakeId: Int): Option[PrivilegeModel] = {
    val query = for {
      (smplTable, privTable) <- sampleMetadata.filter(_.fakeId === sampleFakeId) join privilege.filter(_.userId === userId) on
        ((smplRow, privRow) => smplRow.fakeId === privRow.smplId)
    } yield privTable

    val result = query.result.headOption
    Await.result({
      db.run(result)
    }, Duration.Inf)
  }

  def save(userId: Int, samplesIds: List[Int]) = {
    Await.result({
      db.run(
        sqlu"""DELETE from "privilege" Where "user_id" = ${userId}""")
    }, Duration.Inf)
    samplesIds.foreach(elem => {
      Await.result({
        db.run(
          sqlu"""INSERT INTO "privilege"("user_id", "sample_metadata_id")
              VALUES (${userId}, ${elem})""")
      }, Duration.Inf)
    })
  }
}
