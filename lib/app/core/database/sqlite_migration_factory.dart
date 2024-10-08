import 'package:ceeb_app/app/core/database/migrations/migration.dart';
import 'package:ceeb_app/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
      ];

  List<Migration> getUpgradeMigration(int version) {
    final migrations = <Migration>[];
    return migrations;
  }
}
