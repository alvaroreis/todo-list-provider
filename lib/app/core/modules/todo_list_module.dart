// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

import 'todo_list_page.dart';

class TodoListModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;
  TodoListModule({
    required Map<String, WidgetBuilder> routers,
    List<SingleChildWidget>? bindings,
  })  : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(
          pageBuilder: pageBuilder,
          bindings: _bindings,
        ),
      ),
    );
  }

  Widget getPage(BuildContext context, String path) {
    final widgetBuilder = _routers[path];
    if (null != widgetBuilder) {
      return TodoListPage(
        pageBuilder: widgetBuilder,
        bindings: _bindings,
      );
    }
    throw Exception('Page not found');
  }
}
