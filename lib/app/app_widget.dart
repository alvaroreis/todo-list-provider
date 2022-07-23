import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/database/sqlite_adm_connection.dart';
import 'core/navigator/todo_list_navigator.dart';
import 'core/ui/todo_list_ui_config.dart';
import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';
import 'modules/splash/splash_page.dart';
import 'modules/tasks/tasks_module.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqliteAdm = SqliteAdmConnection();

  @override
  void initState() {
    super.initState();
    // * configure close sqlite connection
    WidgetsBinding.instance.addObserver(sqliteAdm);
  }

  @override
  void dispose() {
    super.dispose();
    // * configure close sqlite connection
    WidgetsBinding.instance.removeObserver(sqliteAdm);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Provider',
      debugShowCheckedModeBanner: false,
      theme: TodoListUiConfig.lightTheme,
      darkTheme: TodoListUiConfig.darkTheme,
      themeMode: ThemeMode.light,
      navigatorKey: TodoListNavigator.navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      routes: {
        ...AuthModule().routers,
        ...HomeModule().routers,
        ...TasksModule().routers
      },
      home: const SplashPage(),
    );
  }
}
