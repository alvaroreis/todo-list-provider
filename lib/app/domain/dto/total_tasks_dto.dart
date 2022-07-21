class TotalTasksDTO {
  final int total;
  final int totalFinish;

  TotalTasksDTO({required this.total, required this.totalFinish});

  int get totalTasks => total - totalFinish;
}
