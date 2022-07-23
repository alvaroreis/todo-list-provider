import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../modules/auth/auth_module.dart';
import '../../modules/home/home_module.dart';
import '../../services/user/user_service.dart';
import '../modules/todo_list_module.dart';
import '../navigator/todo_list_navigator.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserService _userService;

  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService,
  })  : _firebaseAuth = firebaseAuth,
        _userService = userService;

  User? get user => _firebaseAuth.currentUser;

  Future<void> logout() => _userService.logout();

  void listener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) async {
      if (_currentRoute == '/') {
        await Future.delayed(const Duration(milliseconds: 500));
      }
      if (null != user) {
        // TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
        TodoListNavigator.to.pushAndRemoveUntil(
            _getPageBuilder(module: HomeModule(), path: '/home'),
            (route) => false);
      } else if (!_isLoginRoute) {
        // TodoListNavigator.to            .pushNamedAndRemoveUntil('/login', (route) => false);
        TodoListNavigator.to.pushAndRemoveUntil(
            _getPageBuilder(module: AuthModule(), path: '/login'),
            (route) => false);
      }
    });
  }

  bool get _isLoginRoute =>
      _currentRoute.toLowerCase() == '/login' || _currentRoute.isEmpty;

  String get _currentRoute {
    String? currentRoute;
    TodoListNavigator.to.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });
    return currentRoute ?? '';
  }

  PageRouteBuilder _getPageBuilder(
      {Curve curves = Curves.bounceIn,
      required covariant TodoListModule module,
      required String path,
      int transitionDuration = 400}) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: transitionDuration),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(
          curve: curves,
          parent: animation,
        );
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return module.getPage(context, path);
      },
    );
  }
}
