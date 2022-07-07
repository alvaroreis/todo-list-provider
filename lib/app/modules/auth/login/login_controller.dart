import '../../../core/notifier/default_change_notifier.dart';
import '../../../exception/auth_exception.dart';
import '../../../services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.login(email, password);
      if (null == user) {
        throw AuthException(message: 'E-mail ou senha inválidos.');
      }
      success();
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      await _userService.forgotPassword(email);
      setInfoMessage(
        'O link para resetar de senha foi encaminhado para o e-mail.',
      );
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError('Ocorreu um erro ao resetar a senha.');
    } finally {
      hideLoading();
      notifyListeners();
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      final user = await _userService.loginWithGoogle();
      if (null != user) {
        success();
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
