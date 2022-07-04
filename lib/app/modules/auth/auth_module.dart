import 'package:todo_list_provider/app/modules/auth/login/login_page.dart';

import '../../core/modules/todo_list_module.dart';

class AuthModule extends TodoListModule {
  AuthModule()
      : super(
          routers: {
            '/login': (context) => const LoginPage(),
          },
        );
}
