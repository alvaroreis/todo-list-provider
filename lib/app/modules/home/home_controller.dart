import 'dart:developer';

import '../../core/notifier/default_change_notifier.dart';
import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/enum/task_filter_enum.dart';
import '../../domain/models/task_model.dart';
import '../../services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  TaskFilterEnum filterSelected = TaskFilterEnum.today;
  TotalTasksDTO? countToday;
  TotalTasksDTO? countTomorrow;
  TotalTasksDTO? countWeek;
  List<TaskModel> _allTasks = [];
  List<TaskModel> listModels = [];
  DateTime? initialDateWeek;
  DateTime? selectedDateWeek;

  HomeController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  Future<void> loadTasks() async {
    final counts = await Future.wait([
      _tasksService.countToday(),
      _tasksService.countTomorrow(),
      _tasksService.countWeek(),
    ]);

    countToday = counts[0];
    countTomorrow = counts[1];
    countWeek = counts[2];
    await filterTasks(filter: filterSelected);
    notifyListeners();
  }

  Future<void> filterTasks({
    TaskFilterEnum filter = TaskFilterEnum.today,
  }) async {
    try {
      showLoadingAndResetState();
      filterSelected = filter;
      notifyListeners();

      switch (filter) {
        case TaskFilterEnum.today:
          selectedDateWeek = null;
          listModels = await _tasksService.findAllToday();
          break;
        case TaskFilterEnum.tomorrow:
          selectedDateWeek = null;
          listModels = await _tasksService.findAllTomorrow();
          break;
        case TaskFilterEnum.week:
          final weekTask = await _tasksService.findAllWeek();
          initialDateWeek = weekTask.start;
          listModels = weekTask.tasks;
          _filterWeekByDay();
          break;
      }
    } catch (e, s) {
      log('Ocorreu um erro ao buscar tasks', error: e, stackTrace: s);
      setError('Ocorreu um erro ao buscar tasks');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  void refresh() {
    loadTasks();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectedDateWeek = date;
    listModels = _allTasks.where((task) => task.data == date).toList();
    notifyListeners();
  }

  void _filterWeekByDay() {
    if (null != selectedDateWeek) {
      _allTasks = listModels;
      filterByDay(selectedDateWeek!);
    } else if (null != initialDateWeek &&
        filterSelected == TaskFilterEnum.week) {
      _allTasks = listModels;
      filterByDay(initialDateWeek!);
    }
  }
}
