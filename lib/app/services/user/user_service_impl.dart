import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';
import '../../repositories/user/user_repository.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) {
    return _userRepository.register(email, password);
  }

  @override
  Future<User?> login(String email, String password) {
    return _userRepository.login(email, password);
  }

  @override
  Future<void> forgotPassword(String email) {
    return _userRepository.forgotPassword(email);
  }

  @override
  Future<User?> loginWithGoogle() async {
    return await _userRepository.loginWithGoogle();
  }

  @override
  Future<void> logout() {
    return _userRepository.logout();
  }

  @override
  Future<void> updateDisplayName(String name) {
    return _userRepository.updateDisplayName(name);
  }
}
