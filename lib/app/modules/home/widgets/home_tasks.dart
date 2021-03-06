import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../domain/enum/task_filter_enum.dart';
import '../../../domain/models/task_model.dart';
import '../home_controller.dart';
import 'tasks.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Selector<HomeController, String>(
            builder: (context, value, child) {
              return Text(
                "TASK'S $value",
                style: context.titleStyle,
              );
            },
            selector: (context, controller) => controller.filterByFinish
                ? TaskFilterEnum.finish.description
                : controller.filterSelected.description,
          ),
          Column(
            children: context
                .select<HomeController, List<TaskModel>>(
                    (controller) => controller.listModels)
                .map((task) => Tasks(model: task))
                .toList(),
          )
        ],
      ),
    );
  }
}
