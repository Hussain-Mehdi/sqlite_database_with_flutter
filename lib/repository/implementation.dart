import 'package:sqlite_flutte/data/dependency_injection_container.dart';
import 'package:sqlite_flutte/database_instance.dart';
import 'package:sqlite_flutte/message_model.dart';
import 'package:sqlite_flutte/repository/abstraction.dart';

class Repository<T> implements IRepository<T> {
  late final db;

  Repository() {
    db = locator<DatabaseService>();
  }

  @override
  Future<void> add<T>(T object) async {
    await db!.insert('message', Message.toJson(object as Message));
  }

  @override
  Future<String> delete<T>(int id) async {
    try{
    await db!.delete('message', where: 'id=?', whereArgs: [id]);
return "Message deleted successfully";
    }
    catch(e){
      return "there is error, try again";
    }
  }

  @override
  Future<T> get<T>(int id) async {
    List<Map<String, dynamic>> list = await db!.query(
        'SELECT * FROM message WHERE id=?',
        where: 'id =?',
        whereArgs: [id],
        limit: 1);
    return list as T;
  }

  @override
  Future<List<T>> getAll<T>() async {
    List<Map<String, dynamic>> list = await db!.query('message');
    return list.map((e) => Message.fromJson(e)).toList() as List<T>;
  }

  @override
  Future<void> update<T>(T object) async {
    // await db!.update('message', Message.toJson(object as Message),where: 'id=?',whereArgs: [message.id]);
  }
}
