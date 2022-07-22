import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../core/notifier/default_change_notifier.dart';
import '../../domain/dto/total_tasks_dto.dart';
import '../../domain/enum/task_filter_enum.dart';
import '../../domain/models/task_model.dart';
import '../../services/tasks/tasks_service.dart';

class HomeController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  final FirebaseAuth _firebaseAuth;
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
    required FirebaseAuth firebaseAuth,
  })  : _tasksService = tasksService,
        _firebaseAuth = firebaseAuth;

  Future<void> loadTasks() async {
    final userEmail = _firebaseAuth.currentUser!.email!;
    final counts = await Future.wait([
      _tasksService.countToday(userEmail),
      _tasksService.countTomorrow(userEmail),
      _tasksService.countWeek(userEmail),
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
      final userEmail = _firebaseAuth.currentUser!.email!;
      showLoadingAndResetState();
      filterSelected = filter;
      notifyListeners();

      switch (filter) {
        case TaskFilterEnum.today:
          _selectedDateWeek = null;
          listModels = await _tasksService.findAllToday(userEmail);
          break;
        case TaskFilterEnum.tomorrow:
          _selectedDateWeek = null;
          listModels = await _tasksService.findAllTomorrow(userEmail);
          break;
        case TaskFilterEnum.week:
          final weekTask = await _tasksService.findAllWeek(userEmail);
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
      final userEmail = _firebaseAuth.currentUser!.email!;
      showLoadingAndResetState();
      notifyListeners();

      if (null == taskId) {
        throw Exception('O parametro taskId não pode ser nulo.');
      }
      await _tasksService.updateStatus(
        finish: finish,
        taskId: taskId,
        userId: userEmail,
      );
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

  Future<void> deleteTask({required int? taskId}) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      if (null == taskId) {
        throw Exception('O parametro taskId não pode ser nulo.');
      }
      await _tasksService.delete(taskId);
    } catch (e, s) {
      setError('Ocorreu um erro ao deletar a tasks');
      log(
        'Ocorreu um erro ao deletar a tasks. Causa: ${e.toString()}',
        error: e,
        stackTrace: s,
      );
    } finally {
      hideLoading();
      refresh();
    }
  }
}
