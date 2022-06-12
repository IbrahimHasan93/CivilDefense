import 'package:missions/mission_db.dart';
import 'package:missions/mission_modal.dart';
import 'package:sqflite/sqflite.dart';

class MissionDio extends MissionDb {
  static Future<List<MissionModal>> getAllData() async {
    final db = await MissionDb.database;
    final List<Map<String, dynamic>> maps =
        await db.query(MissionDb.missionTable);
    return List<MissionModal>.generate(maps.length, (i) {
      return MissionModal(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
        pandemicName: maps[i]['pandemicName'],
        driverName: maps[i]['driverName'],
        missionTime: maps[i]['missionTime'],
        additionalInfo: maps[i]['additionalInfo'],
      );
    });
  }

  static Future<void> insert(MissionModal missionModal) async {
    final db = await MissionDb.database;
    await db.insert(
      MissionDb.missionTable,
      missionModal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(MissionModal missionModal) async {
    final db = await MissionDb.database;
    await db.update(
      MissionDb.missionTable,
      missionModal.toMap(),
      where: 'id = ?',
      whereArgs: [missionModal.id],
    );
  }

  static Future<void> delete(int id) async {
    final db = await MissionDb.database;
    await db.delete(
      MissionDb.missionTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
