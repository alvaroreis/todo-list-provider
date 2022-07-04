import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory {
  static const int _version = 1;
  static const String _dbName = 'TODO_LIST_PROVIDER';

  static SqliteConnectionFactory? _instance;
  final Lock _lock = Lock();
  Database? _db;

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory() {
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }

  Future<Database> openConnection() async {
    // ! LOCK -> caso este método seja chamado 2x ao mesmo tempo, o _lock fará com que a segunda solicitação
    // ! aguarde o termino da primeira, impedindo assim que sejam criadas varias instancias do _db.
    if (null == _db) {
      await _lock.synchronized(() async {
        String dbPath = await getDatabasesPath();
        String finalPath = join(dbPath, _dbName);

        _db ??= await openDatabase(finalPath,
            version: _version,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade,
            onOpen: _onOpen);
      });
    }

    return _db!;
  }

  void close() {
    _db?.close();
    _db = null;
  }

  Future<void> _onOpen(Database db) async {}
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA FOREIGN_KEYS = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigrations();
    for (var migration in migrations) {
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
    final batch = db.batch();

    final migrations =
        SqliteMigrationFactory().getUpgradeMigrations(oldVersion);

    for (var migration in migrations) {
      migration.upgrade(batch);
    }

    batch.commit();
  }

  Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
}
