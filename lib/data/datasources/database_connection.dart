import 'package:drift/drift.dart';
import 'database_connection_web.dart'
    if (dart.library.io) 'database_connection_io.dart';

class AppDatabaseConnection {
  static QueryExecutor getConnection() => createDatabaseConnection();
}