import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/models/task_model.dart';

abstract class TasksRepository {
  Future<void> delete(int taskId);
  Future<void> save(DateTime date, String description, String userId);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end, String userId);
  Future<TotalTasksDTO> countByPeriod(DateTime start, DateTime end, String userId);
  // Future<void> updateStatus(TaskModel model);
  Future<void> updateStatus({required bool finish, required int taskId, required String userId});
}
