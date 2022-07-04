import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();
  static const Color secondary = Color(0xfff0f3f7);
  static const Color _primary = Color(0xff5c77ce);
  static ThemeData get lightTheme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColor: _primary,
        primaryColorLight: const Color(0xffabc8f7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: _primary),
        ),
      );
}
