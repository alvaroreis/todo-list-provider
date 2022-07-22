import '../models/task_model.dart';

class WeekTasksDTO {
  final DateTime start;
  final DateTime end;
  final List<TaskModel> tasks;
  WeekTasksDTO({
    required this.start,
    required this.end,
    required this.tasks,
  });
}
