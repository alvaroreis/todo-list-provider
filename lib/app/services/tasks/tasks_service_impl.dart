import './tasks_service.dart';
import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/dto/week_tasks_dto.dart';
import '../../domain/models/task_model.dart';
import '../../repositories/tasks/tasks_repository.dart';

class TasksServiceImpl implements TasksService {
  final TasksRepository _tasksRepository;

  TasksServiceImpl({required TasksRepository tasksRepository})
      : _tasksRepository = tasksRepository;

  @override
  Future<void> save(DateTime date, String description, String userId) {
    return _tasksRepository.save(date, description, userId);
  }

  @override
  Future<List<TaskModel>> findAllToday(String userId) {
    final date = DateTime.now();
    return _tasksRepository.findByPeriod(date, date, userId);
  }

  @override
  Future<List<TaskModel>> findAllTomorrow(String userId) {
    final date = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(date, date, userId);
  }

  @override
  Future<WeekTasksDTO> findAllWeek(String userId) async {
    final weekDays = _weekDays;
    final listModels = await _tasksRepository.findByPeriod(
      weekDays.first,
      weekDays.last,
      userId,
    );
    return WeekTasksDTO(
      start: weekDays.first,
      end: weekDays.last,
      tasks: listModels,
    );
  }

  @override
  Future<TotalTasksDTO> countToday(String userId) {
    final date = DateTime.now();
    return _tasksRepository.countByPeriod(date, date, userId);
  }

  @override
  Future<TotalTasksDTO> countTomorrow(String userId) {
    final date = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.countByPeriod(date, date, userId);
  }

  @override
  Future<TotalTasksDTO> countWeek(String userId) async {
    final weekDays = _weekDays;
    return _tasksRepository.countByPeriod(
      weekDays.first,
      weekDays.last,
      userId,
    );
  }

  List<DateTime> get _weekDays {
    final today = DateTime.now();
    DateTime start = DateTime(today.year, today.month, today.day, 0, 0, 0);
    if (start.weekday != DateTime.monday) {
      start.subtract(Duration(days: (start.weekday - 1)));
    }
    final end = start.add(const Duration(days: 7));

    return [start, end];
  }

  @override
  Future<void> updateStatus({
    required bool finish,
    required int taskId,
    required String userId,
  }) {
    return _tasksRepository.updateStatus(
      finish: finish,
      taskId: taskId,
      userId: userId,
    );
  }

  @override
  Future<void> delete(int taskId) {
    return _tasksRepository.delete(taskId);
  }
}
