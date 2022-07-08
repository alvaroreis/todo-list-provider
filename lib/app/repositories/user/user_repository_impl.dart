import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './user_repository.dart';
import '../../exception/auth_exception.dart';

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

      if (e.code != 'email-already-in-use') {
        throw AuthException(
            message: e.message ?? 'Ocorreu um erro ao registrar o usuário');
      } else {
        List<String> loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message:
                  'E-mail já cadastrado, por favor realize o login ou informe outro e-mail.');
        } else {
          throw AuthException(
              message:
                  'Este e-mail já cadastrado com o Google, por favor realize o login ou informe outro e-mail.');
        }
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on PlatformException catch (e, s) {
      log(e.message ?? e.toString(), error: e, stackTrace: s);
      throw AuthException(
          message: e.message ?? 'Ocorreu um erro ao realizar o login.');
    } on FirebaseAuthException catch (e, s) {
      log(e.message ?? e.toString(), error: e, stackTrace: s);
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'E-mail ou senha inválidos.');
      }
      throw AuthException(
          message: e.message ?? 'Ocorreu um erro ao realizar o login.');
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      List<String> loginTypes =
          await _firebaseAuth.fetchSignInMethodsForEmail(email);

      if (loginTypes.contains('password')) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginTypes.contains('google')) {
        throw AuthException(
            message:
                'Não foi possível resetar a senha pois o cadastro foi realizado com o Google.');
      } else {
        throw AuthException(message: 'E-mail não cadastrado.');
      }
    } on PlatformException catch (e, s) {
      log(e.message ?? e.toString(), error: e, stackTrace: s);

      throw AuthException(
          message: e.message ?? 'Ocorreu um erro ao tentar resetar a senha.');
    } on AuthException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw AuthException(message: e.message);
    }
  }

  @override
  Future<User?> loginWithGoogle() async {
    List<String>? loginTypes;
    try {
      await logout();
      final googleUser = await GoogleSignIn().signIn();

      if (null == googleUser) {
        return null;
      }

        loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email);

        if (loginTypes.contains('password')) {
          throw AuthException(
              message:
                  'E-mail já cadastrado, por favor realize o login através do e-mail.');
        }

        final googleAuth = await googleUser.authentication;
        final OAuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential credential =
            await _firebaseAuth.signInWithCredential(
          googleCredential,
        );

        return credential.user;
    } on FirebaseAuthException catch (e, s) {
      log(e.message ?? e.toString(), error: e, stackTrace: s);
      if (e.code == 'account-exists-with-different-credential') {
        throw AuthException(
            message:
                'Login inválido, você se resistrou com os seguintes provedores: ${loginTypes?.join(',')}.');
      }
      throw AuthException(
          message: e.message ?? 'Ocorreu um erro ao realizar o login.');
    }
  }

  @override
  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _firebaseAuth.signOut();
  }
}
