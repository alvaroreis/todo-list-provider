import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/task_model.dart';
import '../home_controller.dart';

class Tasks extends StatelessWidget {
  final TaskModel model;
  final dateFormat = DateFormat('dd/MM/y');
  Tasks({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(5),
          leading: Checkbox(
            value: model.finalizado,
            onChanged: (value) {
              context
                  .read<HomeController>()
                  .updateStatus(finish: value!, taskId: model.id);
            },
          ),
          trailing: IconButton(
              onPressed: () {
                final controller =
                    Provider.of<HomeController>(context, listen: false);
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
                        content: const Text(
                            "Você tem certeza que deseja deletar esta task?"),
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
                            child: const Text(
                              'Deletar',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.close)),
          title: Text(
            model.descricao,
            style: TextStyle(
              decoration: model.finalizado ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(
            dateFormat.format(model.data),
            style: TextStyle(
              decoration: model.finalizado ? TextDecoration.lineThrough : null,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
        ),
      ),
    );
  }
}
