import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();
  static const Color secondary = Color(0xfff0f3f7);
  static const Color _primary = Color(0xff5c77ce);
  static const Color scaffoldBackgroundColor = Color(0xfffafbfe);
  static ThemeData get lightTheme => ThemeData(
        primaryColor: _primary,
        brightness: Brightness.light,
        textTheme: GoogleFonts.mandaliTextTheme(),
        primaryColorLight: const Color(0xffabc8f7),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: _primary),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _primary,
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: _primary),
          titleTextStyle: TextStyle(color: _primary),
          backgroundColor: scaffoldBackgroundColor,
        ),
      );
}
