import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../domain/dto/total_tasks_dto.dart';
import '../../../domain/enum/task_filter_enum.dart';
import '../home_controller.dart';
import 'task_card_filter.dart';

class HomeFilters extends StatelessWidget {
  const HomeFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FILTROS',
          style: context.titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              TodoCardFilter(
                label: 'HOJE',
                taskFilter: TaskFilterEnum.today,
                totalTasks: context.select<HomeController, TotalTasksDTO?>(
                  (value) => value.countToday,
                ),
                selected: context.select<HomeController, bool>(
                  (value) => value.filterSelected == TaskFilterEnum.today,
                ),
              ),
              TodoCardFilter(
                label: 'AMANHÃ',
                taskFilter: TaskFilterEnum.tomorrow,
                totalTasks: context.select<HomeController, TotalTasksDTO?>(
                  (value) => value.countTomorrow,
                ),
                selected: context.select<HomeController, bool>(
                  (value) => value.filterSelected == TaskFilterEnum.tomorrow,
                ),
              ),
              TodoCardFilter(
                label: 'SEMANA',
                taskFilter: TaskFilterEnum.week,
                totalTasks: context.select<HomeController, TotalTasksDTO?>(
                  (value) => value.countWeek,
                ),
                selected: context.select<HomeController, bool>(
                  (value) => value.filterSelected == TaskFilterEnum.week,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
