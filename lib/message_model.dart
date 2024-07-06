import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutte/database_instance.dart';

class Message {
  int id;
  String title;
  String description;
  DateTime date;

  Message(this.id, this.title, this.description, this.date);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        json['id'], json['title'], json['description'], json['date']);
  }

  static Map<String, Object?> toJson(Message message) {
    return {
      'id': message.id,
      'title': message.title,
      'description': message.description,
      'date': message.date
    };
  }

  static Future insertMessage(Message message) async {
    try {
      final db = await DatabaseService.getInstance();
      await db.insert('message', toJson(message),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print("There is error in saving the message");
    }
  }

  static Future<List<Message>> getAllMessages() async {
    try {
      final db = await DatabaseService.getInstance();
      final List<Map<String, Object?>> messageMap = await db.query('dog');
      return [
        for (final {
              'id': id as int,
              'title': title as String,
              'description': description as String,
              'date': date as DateTime
            } in messageMap)
          Message(id, title, description, date)
      ];
    } catch (e) {
      print("There is error in fetching messages: ${e}");
      return [];
    }
  }
}
