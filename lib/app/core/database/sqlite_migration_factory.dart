import 'migrations/migration.dart';
import 'migrations/migrationV1.dart';
import 'migrations/migrationV2.dart';
import 'migrations/migrationV3.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [
        MigrationV1(),
        MigrationV2(),
        MigrationV3(),
      ];
  List<Migration> getUpgradeMigrations(int oldVersion) {
    final migrations = <Migration>[];
    if (oldVersion == 1) {
      migrations.add(MigrationV2());
      migrations.add(MigrationV3());
    }

    if (oldVersion == 2) {
      migrations.add(MigrationV3());
    }

    return migrations;
  }
}
