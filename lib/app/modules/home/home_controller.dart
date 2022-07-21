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
  DateTime? _selectedDateWeek;
  bool filterByFinish = false;

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
          _selectedDateWeek = null;
          listModels = await _tasksService.findAllToday();
          break;
        case TaskFilterEnum.tomorrow:
          _selectedDateWeek = null;
          listModels = await _tasksService.findAllTomorrow();
          break;
        case TaskFilterEnum.week:
          final weekTask = await _tasksService.findAllWeek();
          initialDateWeek = weekTask.start;
          listModels = weekTask.tasks;
          _allTasks = weekTask.tasks;
          filterByParams(date: _selectedDateWeek ?? initialDateWeek);
          break;
        case TaskFilterEnum.finish:
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
  }

  Future<void> filterByStatus() async {
    await loadTasks();
    filterByFinish = !filterByFinish;
    if (filterSelected != TaskFilterEnum.week) {
      _allTasks = listModels;
    }

    filterByParams(date: _selectedDateWeek);
  }

  void filterByParams({required DateTime? date}) {
    listModels = _allTasks.where((task) {
      bool valido = true;

      if (filterByFinish && task.finalizado != true) {
        valido = false;
      }

      if (null != date) {
        _selectedDateWeek = date;
        if (filterSelected == TaskFilterEnum.week &&
            task.data != _selectedDateWeek) {
          valido = false;
        }
      }

      return valido;
    }).toList();
    notifyListeners();
  }

  Future<void> updateStatus(
      {required bool finish, required int? taskId}) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (null == taskId) {
        throw Exception('O parametro taskId não pode ser nulo.');
      }
      await _tasksService.updateStatus(finish: finish, taskId: taskId);
    } catch (e, s) {
      setError('Ocorreu um erro ao atualizar o status da tasks');
      log(
        'Ocorreu um erro ao atualizar o status da tasks. Causa: ${e.toString()}',
        error: e,
        stackTrace: s,
      );
    } finally {
      hideLoading();
      refresh();
    }
  }
}
