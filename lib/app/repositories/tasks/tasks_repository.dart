import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/models/task_model.dart';

abstract class TasksRepository {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
  Future<TotalTasksDTO> countByPeriod(DateTime start, DateTime end);
}
