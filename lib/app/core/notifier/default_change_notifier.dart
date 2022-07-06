import 'package:flutter/material.dart';

abstract class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  bool _success = false;
  String? _error;

  bool get loading => _loading;
  bool get hasError => null != error;
  bool get isSuccess => _success;
  String? get error => _error;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _success = true;
  void setError(String? error) => _error = _error;
  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    _error = null;
    _success = false;
  }
}
