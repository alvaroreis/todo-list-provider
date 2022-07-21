// ignore_for_file: public_member_api_docs, sort_constructors_first
import './tasks_repository.dart';
import '../../core/database/sqlite_connection_factory.dart';
import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/models/task_model.dart';

class TasksRepositoryImpl implements TasksRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  TasksRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final model = TaskModel(descricao: description, data: date);
    await conn.insert('todo', model.toMap());
    // await conn.insert('todo', {
    //   'id': null,
    //   'descricao': description,
    //   'data_hora': date.toIso8601String(),
    //   'finalizado': 0,
    // });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    start = DateTime(start.year, start.month, start.day, 0, 0, 0);
    end = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final result = await conn.rawQuery(
      '''
      SELECT * FROM TODO 
      WHERE data_hora between ? and ?
      ORDER BY data_hora DESC
    ''',
      [start.toIso8601String(), end.toIso8601String()],
    );
    return result.map(TaskModel.fromMap).toList();
  }

  @override
  Future<TotalTasksDTO> countByPeriod(DateTime start, DateTime end) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    start = DateTime(start.year, start.month, start.day, 0, 0, 0);
    end = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final result = await conn.rawQuery(
      '''
      SELECT COUNT(*) AS count_total, 
      SUM(CASE WHEN finalizado = 1 THEN 1 ELSE 0 END) AS count_finish 
      FROM TODO WHERE data_hora between ? and ?
    ''',
      [start.toIso8601String(), end.toIso8601String()],
    );
    return result.map(
      (e) {
        int countTotal = e['count_total'] as int? ?? 0;
        int countFinish = e['count_finish'] as int? ?? 0;
        return TotalTasksDTO(
          total: countTotal,
          totalFinish: countFinish,
        );
      },
    ).first;
  }

  @override
  Future<void> updateStatus({required bool finish, required int taskId}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.rawUpdate(
      'UPDATE TODO SET finalizado = ? WHERE id = ?',
      [finish, taskId],
    );
  }
}
