import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {
  String label;
  bool isDense;
  bool obscureText;
  IconButton? suffixIconButton;
  ValueNotifier<bool> obscureTextVN;
  TextEditingController? controller;
  FormFieldValidator<String>? validator;

  TodoListField({
    Key? key,
    this.isDense = true,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
    required this.label,
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
          controller: controller,
          validator: validator,
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
