import 'package:ceeb_app/app/core/database/migrations/migration.dart';
import 'package:ceeb_app/app/core/helpers/tables_sql.dart';
import 'package:sqflite/sqflite.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute(TablesSql.CATEGORY);
    batch.execute(TablesSql.BOOK);
    batch.execute(TablesSql.NOTES);
    batch.execute(TablesSql.READER);
    batch.execute(TablesSql.INVOICE);
    batch.execute(TablesSql.LENDING);
    batch.execute(TablesSql.CONFIGURATION);
    batch.execute(TablesSql.INSERT_DEFAULT_CONFIGURATION);
  }

  @override
  void update(Batch batch) {}
}
