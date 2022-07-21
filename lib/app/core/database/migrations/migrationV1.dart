// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class MigrationV1 extends Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      create table todo(
        id integer primary key autoincrement,
        descricao varchar(500) not null,
        user_id varchar(100) not null,
        data datetime,
        finalizado integer
      )
    ''');
  }

  @override
  void upgrade(Batch batch) {}
}
