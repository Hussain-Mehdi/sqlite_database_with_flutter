import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static var database = null;

  DatabaseService._privateConstructor();

  static Future<Database> getInstance() async {
    if (database == null) {
      return database = await openDatabase(
          join(await getDatabasesPath(), 'message_database.db'));
    }
    return database;
  }

  static createTable() async {
    database =
        openDatabase(join(await getDatabasesPath(), 'message_database.db'),
            onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE message(id INTEGER PRIMARY KEY,title TEXT,description TEXT,date DATETIME)");
    }, version: 1);
  }
}
