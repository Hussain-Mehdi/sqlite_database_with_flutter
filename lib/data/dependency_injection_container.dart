import 'package:get_it/get_it.dart';
import 'package:sqlite_flutte/database_instance.dart';
import 'package:sqlite_flutte/message%20repository/message_repository.dart';
import 'package:sqlite_flutte/repository/implementation.dart';

var locator = GetIt.instance;

void setup(){
  locator.registerSingleton<Repository>(Repository());
  locator.registerSingleton<MessageRepository>(MessageRepository());
  locator.registerSingleton<DatabaseService>(DatabaseService());
}