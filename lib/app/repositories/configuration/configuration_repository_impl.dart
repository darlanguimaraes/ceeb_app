import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/models/configuration/configuration_model.dart';

import './configuration_repository.dart';

class ConfigurationRepositoryImpl implements ConfigurationRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;

  ConfigurationRepositoryImpl(
      {required SqliteConnectionFactory sqliteConnectionFactory})
      : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<ConfigurationModel> get() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result =
        await conn.rawQuery('select * from ${Constants.TABLE_CONFIGURATION}');
    return ConfigurationModel.fromMap(result[0]);
  }

  @override
  Future<void> update(ConfigurationModel configuration) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.update(
      Constants.TABLE_CONFIGURATION,
      configuration.toMap(),
      where: 'id>?',
      whereArgs: [0],
    );
  }
}
