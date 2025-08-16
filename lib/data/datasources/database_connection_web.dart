import 'package:drift/drift.dart';

QueryExecutor createDatabaseConnection() {
  // For web demo, return a simple in-memory database
  // This will show empty state but won't crash
  return _FakeDatabaseConnection();
}

class _FakeDatabaseConnection extends QueryExecutor {
  @override
  SqlDialect get dialect => SqlDialect.sqlite;

  @override
  TransactionExecutor beginTransaction() => throw UnsupportedError('Demo mode');

  @override
  Future<bool> ensureOpen(QueryExecutorUser user) async {
    await user.beforeOpen(this, OpeningDetails(null, 1));
    return true;
  }

  @override
  Future<void> runBatched(BatchedStatements statements) async {}

  @override
  Future<int> runDelete(String statement, List<Object?> args) async => 0;

  @override
  Future<int> runInsert(String statement, List<Object?> args) async => 0;

  @override
  Future<List<Map<String, Object?>>> runSelect(String statement, List<Object?> args) async => [];

  @override
  Future<int> runUpdate(String statement, List<Object?> args) async => 0;

  @override
  Future<void> runCustom(String statement, [List<Object?>? args]) async {}

  @override
  TransactionExecutor beginExclusive() => throw UnsupportedError('Demo mode');
}