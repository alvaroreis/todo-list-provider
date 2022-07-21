import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/dto/week_tasks_dto.dart';
import '../../domain/models/task_model.dart';

abstract class TasksService {
  Future<void> save(DateTime date, String description, String userId);
  Future<List<TaskModel>> findAllToday(String userId);
  Future<List<TaskModel>> findAllTomorrow(String userId);
  Future<WeekTasksDTO> findAllWeek(String userId);
  Future<TotalTasksDTO> countToday(String userId);
  Future<TotalTasksDTO> countTomorrow(String userId);
  Future<TotalTasksDTO> countWeek(String userId);
  // Future<void> updateStatus(TaskModel model);
  Future<void> updateStatus({
    required bool finish,
    required int taskId,
    required String userId,
  });
}
