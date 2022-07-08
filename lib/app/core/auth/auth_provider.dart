import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/user/user_service.dart';
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
    _firebaseAuth.idTokenChanges().listen((user) {
      if (null != user) {
        TodoListNavigator.to.pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      } else if (!_isLoginRoute) {
        TodoListNavigator.to.pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    });
  }

  bool get _isLoginRoute => _currentRoute.toLowerCase().contains('login');

  String get _currentRoute {
    String? currentRoute;
    TodoListNavigator.to.popUntil((route) {
      currentRoute = route.settings.name;
      return true;
    });
    return currentRoute ?? '';
  }
}
