import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;
  String? error;
  bool success = false;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> register(String email, String password) async {
    limparCampos();
    try {
      final user = await _userService.register(email, password);

      if (null == user) {
        throw AuthException(message: 'Ocorreu um erro ao registrar usuário');
      }
      success = true;
    } on AuthException catch (e) {
      error = e.message;
    } finally {
      notifyListeners();
    }
  }

  void limparCampos() {
    error = null;
    success = false;
    notifyListeners();
  }
}
