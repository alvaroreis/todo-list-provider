import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/notifier/default_listener_notifier.dart';
import '../../../core/ui/theme_extensions.dart';
import '../../../core/widgets/todo_list_field.dart';
import 'tasks_create_controller.dart';
import 'widget/calendar_buttom.dart';

class TasksCreatePage extends StatefulWidget {
  final TasksCreateController _controller;
  const TasksCreatePage({
    Key? key,
    required final TasksCreateController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  State<TasksCreatePage> createState() => _TasksCreatePageState();
}

class _TasksCreatePageState extends State<TasksCreatePage> {
  final _descriptionEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _descriptionFocus = FocusNode();

  @override
  void dispose() {
    _descriptionEC.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    DefaultListenerNotifier(changeNotifier: widget._controller).listener(
      context: context,
      successCallback: (notifier, listener) {
        listener.dispose();
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final valid = _formKey.currentState?.validate() ?? false;
          if (valid) {
            final description = _descriptionEC.text;
            await widget._controller.save(description);
          }
        },
        label: const Text(
          'Salvar',
          // style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Criar atividade',
                  style: context.titleStyle.copyWith(fontSize: 28),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TodoListField(
                label: '',
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                controller: _descriptionEC,
                focusNode: _descriptionFocus,
                validator: Validatorless.multiple([
                  Validatorless.required('Campo obrigatório'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              CalendarButtom()
            ],
          ),
        ),
      ),
    );
  }
}
