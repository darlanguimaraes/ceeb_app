import 'package:ceeb_app/app/core/database/sqlite_migration_factory.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

class SqliteConnectionFactory {
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'CEEB_APP';

  static SqliteConnectionFactory? _instance;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  static SqliteConnectionFactory get instance =>
      _instance ??= SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return instance;
  }

  Future<Database> openConnection() async {
    var dataBasePath = await getDatabasesPath();
    var databasePathFinal = join(dataBasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        _db ??= await openDatabase(
          databasePathFinal,
          version: _VERSION,
          onConfigure: _onConfigure,
          onCreate: _onCreate,
          onUpgrade: _onUpgrade,
          onDowngrade: _onDowngrade,
        );
      });
    }
    return _db!;
  }

  void closeConnection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
