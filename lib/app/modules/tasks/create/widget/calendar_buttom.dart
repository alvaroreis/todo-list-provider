import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/theme_extensions.dart';
import '../tasks_create_controller.dart';

typedef SelectedDate = void Function(DateTime? dateTime);

class CalendarButtom extends StatelessWidget {
  CalendarButtom({Key? key}) : super(key: key);
  final _dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _showCalendar(
      BuildContext context, SelectedDate onSuccess) async {
    final DateTime today = DateTime.now();
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(2000),
      lastDate: DateTime(today.year + 10),
    );
    onSuccess.call(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        _showCalendar(
          context,
          (date) {
            context.read<TasksCreateController>().selectedDate = date;
          },
        );
      },
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.today,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 10,
            ),
            Selector<TasksCreateController, String>(
              selector: (context, controller) {
                final date = controller.selectedDate;
                if (null != date) {
                  return _dateFormat.format(date);
                }
                return 'SELECIONE UMA DATA';
              },
              builder: (context, value, child) {
                return Text(value, style: context.titleStyle);
              },
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
