import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/task_model.dart';
import '../home_controller.dart';

class Tasks extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  final ValueNotifier<bool> _checked;

  Tasks({Key? key, required this.model})
      : _checked = ValueNotifier(model.finalizado),
        super(key: key);

  void _showRemoveDialog(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider<HomeController>.value(
          value: controller,
          builder: (context, child) => AlertDialog(
            title: const Text(
              "Deletar Task",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content:
                const Text("Você tem certeza que deseja deletar esta task?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                ),
              ),
              TextButton(
                onPressed: () async {
                  controller.deleteTask(taskId: model.id);
                  Navigator.pop(context);
                },
                child: Text(
                  'Deletar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateStatus(BuildContext context, bool? value) {
    context
        .read<HomeController>()
        .updateStatus(finish: value!, taskId: model.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Theme.of(context).disabledColor),
            ],
          ),
          // margin:
          child: IntrinsicHeight(
            child: ValueListenableBuilder(
              valueListenable: _checked,
              builder: (context, value, child) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).disabledColor.withAlpha(40),
                    ),
                  ),
                  onTap: () {
                    bool value = !_checked.value;
                    _updateStatus(context, value);
                  },
                  onLongPress: () {
                    _showRemoveDialog(context);
                  },
                  leading: Checkbox(
                    value: _checked.value,
                    onChanged: (value) {
                      _updateStatus(context, value);
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      _showRemoveDialog(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  title: Text(
                    model.descricao,
                    style: TextStyle(
                      decoration:
                          model.finalizado ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    dateFormat.format(model.data),
                    style: TextStyle(
                      decoration:
                          model.finalizado ? TextDecoration.lineThrough : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
