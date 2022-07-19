import 'dart:developer';

import '../../../core/notifier/default_change_notifier.dart';
import '../../../services/tasks/tasks_service.dart';

class TasksCreateController extends DefaultChangeNotifier {
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TasksCreateController({
    required TasksService tasksService,
  }) : _tasksService = tasksService;

  set selectedDate(DateTime? dateTime) {
    _selectedDate = dateTime;
    resetState();
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String description) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if (null == _selectedDate) {
        throw Exception('date-is-null');
      }
      await _tasksService.save(selectedDate!, description);
      success();
    } catch (e, s) {
      String error = 'Ocorreu um erro ao cadastrar a Task.';

      if (e.toString().contains('date-is-null')) {
        error = 'Data não selecionada.';
      }

      log(error, error: e, stackTrace: s);
      setError(error);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
