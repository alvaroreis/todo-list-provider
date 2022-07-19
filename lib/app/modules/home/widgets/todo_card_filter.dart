import 'package:flutter/material.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../domain/dto/total_tasks_dto.dart';
import '../../../domain/enum/task_filter_enum.dart';

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
    if (null != totalTasks) {
      final total = totalTasks!.total;
      final finish = totalTasks!.totalFinish;

      final percent = (finish * 100) / total;
      return percent / 100;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : context.primaryColor;
    final cardColor = selected ? context.primaryColor : Colors.white;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 1, color: Colors.grey.withOpacity(.8))),
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const SizedBox(
          //   width: 21,
          //   height: 21,
          // ),
          Text(
            '${totalTasks?.total ?? 0} TASKS',
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
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
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
    );
  }
}
