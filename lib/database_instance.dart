import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  
  DatabaseService();

  static Database? database = null;
  DatabaseService._privateConstructor();
  static bool isTableCreated=true;

   Future<Database?> getInstance() async {
    if (database == null) {
      database =  await openDatabase(
          join(await getDatabasesPath(), 'message_database.db'));
      if(isTableCreated)
      {
        await createTable();
        isTableCreated=false;
      }
      return database;
    } else {
      if(isTableCreated)
      {
        await createTable();
        isTableCreated=false;
      }
      return database;
    }
  }

    createTable() async {
    try {
      print("Creating table");
      await database?.execute("CREATE TABLE message(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,description TEXT,date TEXT)");
      print("Table created");

    } catch (e) {
      print("Table is not created");
    }
  }

   Future<List<Map<String, Object?>>>  getAllTables()async{
    return await database!.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
  }
}
