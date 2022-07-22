// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class MigrationV2 extends Migration {
  @override
  void create(Batch batch) {
    batch.execute('create table teste2(id integer)');
  }

  @override
  void upgrade(Batch batch) {
    batch.execute('create table teste(id integer)');
  }
}
