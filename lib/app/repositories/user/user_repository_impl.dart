import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e, s) {
      log(e.message ?? e.toString(), error: e, stackTrace: s);

      // ! email-already-exists
      if (e.code != 'email-already-in-use') {
        throw AuthException(
            message: e.message ?? 'Erro ao registrar o usuário');
      } else {
        List<String> loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message:
                  'E-mail já cadastrado, por favor informar outro e-mail.');
        } else {
          throw AuthException(
              message:
                  'Este e-mail já cadastrado com o Google, por favor realize o login através do método ou informar outro e-mail.');
        }
      }
    }
  }
}
