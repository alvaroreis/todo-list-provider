// ignore_for_file: public_member_api_docs, sort_constructors_first
import './tasks_repository.dart';
import '../../core/database/sqlite_connection_factory.dart';
import '../../domain/models/todo_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final model = TodoModel(descricao: description, data: date);
    await conn.insert('todo', model.toMap());
    // await conn.insert('todo', {
    //   'id': null,
    //   'descricao': description,
    //   'data_horaid': date.toIso8601String(),
    //   'finalizado': 0,
    // });
  }
}


      //  id integer primary key autoincrement,
      //   descricao varchar(500) not null,
      //   data_hora datetime,
      //   finalizado integer