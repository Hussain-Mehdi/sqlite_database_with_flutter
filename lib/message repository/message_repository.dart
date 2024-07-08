import 'package:sqlite_flutte/message_model.dart';
import 'package:sqlite_flutte/repository/abstraction.dart';
import 'package:sqlite_flutte/repository/implementation.dart';

class MessageRepository implements Repository<Message>, IRepository<Message> {
  // late final _db;
  // MessageRepository() {
  //   _db = locator<Repository>();
  // }

  @override
  var db;

  @override
  Future<void> add<Message>(Message object) async {
    await db.add<Message>(object);
  }

  @override
  Future<String> delete<Message>(int id) async {
    return await db.delete<Message>(id);
  }

  @override
  Future<Message> get<Message>(int id) async {
    return await db.get<Message>(id);
  }

  @override
  Future<List<Message>> getAll<Message>() async {
    return await db.getAll<Message>();
  }

  @override
  Future<void> update<Message>(Message object) async {}
  

}
