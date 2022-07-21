import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../domain/dto/total_tasks_dto.dart';
import '../../../domain/enum/task_filter_enum.dart';
import '../home_controller.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskFilter,
    required this.selected,
    this.totalTasks,
  }) : super(key: key);

  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksDTO? totalTasks;
  final bool selected;

  double get _percentFinish {
    if (null != totalTasks && totalTasks?.total != totalTasks?.totalFinish) {
      final total = totalTasks!.total;
      final finish = totalTasks!.totalFinish;

      final percent = (finish * 100) / total;
      return percent / 100;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () =>
            context.read<HomeController>().filterTasks(filter: taskFilter),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
            maxWidth: 150,
          ),
          decoration: BoxDecoration(
              color: selected ? context.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.grey.withOpacity(.8))),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${totalTasks?.totalTasks} TASK'S",
                style: context.titleStyle.copyWith(
                  fontSize: 10,
                  color: selected ? Colors.white : Colors.grey,
                ),
              ),
              Text(
                label,
                style: context.titleStyle.copyWith(
                  fontSize: 20,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: _percentFinish),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    backgroundColor: selected
                        ? context.primaryColorLight
                        : Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      selected ? Colors.white : context.primaryColor,
                    ),
                    value: value,
                  );
                },
                duration: const Duration(seconds: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
