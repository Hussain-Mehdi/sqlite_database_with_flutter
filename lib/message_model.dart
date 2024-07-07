import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutte/database_instance.dart';

class Message {
  int? id;
  String title;
  String description;
  String date;

  Message(this.id, this.title, this.description, this.date);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        json['id'], json['title'], json['description'], json['date']);
  }

  static Map<String, Object?> toJson(Message message) {
    return {
      
      'title': message.title,
      'description': message.description,
      'date': message.date
    };
  }

  static Future insertMessage(Message message) async {
    try {
      final db = await DatabaseService.getInstance();
      await db!.insert('message', toJson(message),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
    }
  }

  static Future<List<Message>> getAllMessages() async {
    try {
      final db = await DatabaseService.getInstance();
      final List<Map<String, Object?>> messageMap = await db!.query('message');
      return [
        for (final {
              'id': id as int,
              'title': title as String,
              'description': description as String,
              'date': date as String
            } in messageMap)
          Message(id, title, description, date.toString())
      ];
    } catch (e) {
      return [];
    }
  }

  static Future<void> updateMessage(Message message)async{
    try{
    final db = await DatabaseService.getInstance();
    await db!.update('message', Message.toJson(message),where: 'id=?',whereArgs: [message.id]);
    }
    catch(e){
    }
  }

  static Future<String> deletedMessage(int id)async{
    try {
      final db = await DatabaseService.getInstance();
    await db!.delete('message',where: 'id=?', whereArgs: [id]);
    return "Message Deleted successfully";
    } catch (e) {
      return "there is error message isn't deleted";
    }
  }
}
