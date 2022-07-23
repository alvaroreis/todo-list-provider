import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/theme_extensions.dart';
import '../../../domain/enum/task_filter_enum.dart';
import '../home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.select<HomeController, bool>(
        (value) => value.filterSelected == TaskFilterEnum.week,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            'DIA DA SEMANA',
            style: context.titleStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (ctx, controller) =>
                  controller.initialDateWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker(
                  value,
                  locale: 'pt_BR',
                  initialSelectedDate: value,
                  selectionColor: context.primaryColor,
                  selectedTextColor: Theme.of(context).colorScheme.secondary,
                  daysCount: 7,
                  monthTextStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 8),
                  dayTextStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                  dateTextStyle: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 13),
                  onDateChange: (selectedDate) {
                    context
                        .read<HomeController>()
                        .filterByParams(date: selectedDate);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
