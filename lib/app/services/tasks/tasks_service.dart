import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/dto/week_tasks_dto.dart';
import '../../domain/models/task_model.dart';

abstract class TasksService {
  Future<void> save(DateTime date, String description);
  Future<List<TaskModel>> findAllToday();
  Future<List<TaskModel>> findAllTomorrow();
  Future<WeekTasksDTO> findAllWeek();
  Future<TotalTasksDTO> countToday();
  Future<TotalTasksDTO> countTomorrow();
  Future<TotalTasksDTO> countWeek();

}
