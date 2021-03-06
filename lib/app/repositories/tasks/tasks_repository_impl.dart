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
  Future<void> save(DateTime date, String description, String userId) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final model = TaskModel(descricao: description, data: date, userId: userId);
    await conn.insert('todo', model.toMap());
    // await conn.insert('todo', {
    //   'id': null,
    //   'descricao': description,
    //   'data': date.toIso8601String(),
    //   'finalizado': 0,
    // });
  }

  @override
  Future<List<TaskModel>> findByPeriod(
      DateTime start, DateTime end, String userId) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    start = DateTime(start.year, start.month, start.day, 0, 0, 0);
    end = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final result = await conn.rawQuery(
      '''
      SELECT * FROM TODO 
      WHERE data between ? and ?
      AND user_id = ?
      ORDER BY data DESC
    ''',
      [start.toIso8601String(), end.toIso8601String(), userId],
    );
    return result.map(TaskModel.fromMap).toList();
  }

  @override
  Future<TotalTasksDTO> countByPeriod(
      DateTime start, DateTime end, String userId) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    start = DateTime(start.year, start.month, start.day, 0, 0, 0);
    end = DateTime(end.year, end.month, end.day, 23, 59, 59);

    final result = await conn.rawQuery(
      '''
      SELECT COUNT(*) AS count_total, 
      SUM(CASE WHEN finalizado = 1  THEN 1 ELSE 0 END) AS count_finish 
      FROM TODO WHERE data between ? and ?
      AND user_id = ?
    ''',
      [start.toIso8601String(), end.toIso8601String(), userId],
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
  Future<void> updateStatus(
      {required bool finish,
      required int taskId,
      required String userId}) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.rawUpdate(
      'UPDATE TODO SET finalizado = ? WHERE id = ? AND user_id = ?',
      [finish, taskId, userId],
    );
  }
  
  @override
  Future<void> delete(int taskId) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.rawUpdate(
      'DELETE FROM TODO WHERE id = ?',
      [taskId],
    );
  }
}
