import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../ui/messages.dart';
import 'default_change_notifier.dart';

typedef EverVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listener,
);
typedef SuccessVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listener,
);
typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier notifier,
  DefaultListenerNotifier listener,
);

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({required this.changeNotifier});

  void listener({
    required BuildContext context,
    required SuccessVoidCallback successCallback,
    ErrorVoidCallback? errorCallback,
    EverVoidCallback? everCallback,
  }) {
    changeNotifier.addListener(() {
      if (null != everCallback) {
        everCallback(changeNotifier, this);
      }

      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (null != errorCallback) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(
          changeNotifier.error ?? 'Internal error.',
        );
      } else if (changeNotifier.isSuccess) {
        successCallback(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}
