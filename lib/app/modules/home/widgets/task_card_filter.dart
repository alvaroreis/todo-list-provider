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
    final total = totalTasks?.total ?? 0;
    final finish = totalTasks?.totalFinish ?? 0;

    if (0 == total && 0 == finish) {
      return 0.0;
    }

    final percent = (finish * 100) / total;
    return percent / 100;
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
              color: selected
                  ? context.primaryColor
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 1,
                color: Theme.of(context).dividerColor.withOpacity(.8),
              )),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "${totalTasks?.totalTasks} TASK'S",
                style: context.titleStyle.copyWith(
                  fontSize: 10,
                  color: selected
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).dividerColor,
                ),
              ),
              Text(
                label,
                style: context.titleStyle.copyWith(
                  fontSize: 20,
                  color: selected
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).primaryColorDark,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: _percentFinish),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    backgroundColor: selected
                        ? context.primaryColorLight
                        : Theme.of(context).dividerColor.withAlpha(90),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      selected
                          ? Theme.of(context).colorScheme.secondary
                          : context.primaryColor,
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
