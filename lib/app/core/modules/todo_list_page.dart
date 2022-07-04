import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {
  final WidgetBuilder _pageBuilder;
  final List<SingleChildWidget>? _bindings;

  const TodoListPage({
    super.key,
    required WidgetBuilder pageBuilder,
    List<SingleChildWidget>? bindings,
  })  : _pageBuilder = pageBuilder,
        _bindings = bindings;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ?? [Provider(create: (context) => Object())],
      child: Builder(
        builder: (context) => _pageBuilder(context),
      ),
    );
  }
}
