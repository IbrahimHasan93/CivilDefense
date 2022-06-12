import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MissionDb {
  // ignore: prefer_typing_uninitialized_variables
  static late final database;
  static String missionTable = 'mission';
  static initDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'mission_db.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $missionTable (id INTEGER AUTO_INCREMENT PRIMARY KEY, name TEXT, age INTEGER, pandemicName TEXT,missionTime TEXT,driverName TEXT,additionalInfo TEXT)',
        );
      },
      version: 1,
    );
  }
}
