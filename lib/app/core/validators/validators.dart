import 'package:flutter/material.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(
    TextEditingController? valueEC,
    String message,
  ) {
    return (valeu) {
      final valueCompare = valueEC?.text ?? '';
      if (null == valeu || (null != valeu && valeu != valueCompare)) {
        return message;
      }
      return null;
    };
  }
}
