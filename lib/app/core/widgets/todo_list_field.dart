import 'package:flutter/material.dart';

import '../ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  final String label;
  final bool isDense;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool autofocus;

  TodoListField({
    Key? key,
    this.isDense = true,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
    required this.label,
    this.focusNode,
    this.autofocus = false,
  })  : assert(
          true == obscureText ? suffixIconButton == null : true,
          'obscureText não pode ser enviado junto com o suffixIconButton',
        ),
        obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, obscureTextValue, child) {
        return TextFormField(
          key: key,
          autofocus: autofocus,
          controller: controller,
          validator: validator,
          focusNode: focusNode,
          obscureText: obscureTextValue,
          decoration: InputDecoration(
            isDense: isDense,
            labelText: label,
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            suffixIcon: suffixIconButton ??
                (true == obscureText
                    ? IconButton(
                        onPressed: () {
                          obscureTextVN.value = !obscureTextValue;
                        },
                        icon: Icon(
                          obscureTextValue
                              ? TodoListIcons.eye
                              : TodoListIcons.eye_slash,
                          size: 15,
                        ),
                      )
                    : null),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        );
      },
    );
  }
}
