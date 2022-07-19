import './tasks_service.dart';
import '../../domain/dto/week_tasks_dto.dart';
import '../../domain/models/task_model.dart';
import '../../repositories/tasks/tasks_repository.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description) {
    return _tasksRepository.save(date, description);
  }

  @override
  Future<List<TaskModel>> findAllToday() {
    final date = DateTime.now();
    return _tasksRepository.findByPeriod(date, date);
  }

  @override
  Future<List<TaskModel>> findAllTomorrow() {
    final date = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(date, date);
  }

  @override
  Future<WeekTasksDTO> findAllWeek() async {
    final today = DateTime.now();
    DateTime start = DateTime(today.year, today.month, today.day, 0, 0, 0);
    if (start.weekday != DateTime.monday) {
      start.subtract(Duration(days: (start.weekday - 1)));
    }
    final end = start.add(const Duration(days: 7));
    final listModels = await _tasksRepository.findByPeriod(start, end);
    return WeekTasksDTO(start: start, end: end, tasks: listModels);
  }
}
