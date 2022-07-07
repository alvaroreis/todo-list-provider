import 'package:flutter/material.dart';

abstract class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  bool _success = false;
  String? _error;
  String? _infoMessage;

  bool get loading => _loading;
  bool get hasError => null != error;
  bool get hasInfo => null != infoMessage;

  bool get isSuccess => _success;
  String? get error => _error;
  String? get infoMessage => _infoMessage;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _success = true;
  void setError(String? error) => _error = error;
  void setInfoMessage(String? message) => _infoMessage = message;
  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    _error = null;
    _infoMessage = null;
    _success = false;
  }
}
