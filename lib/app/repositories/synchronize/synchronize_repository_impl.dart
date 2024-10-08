import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';

import './synchronize_repository.dart';

class SynchronizeRepositoryImpl implements SynchronizeRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  SynchronizeRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> synchronize() {
    throw UnimplementedError();
  }
}
