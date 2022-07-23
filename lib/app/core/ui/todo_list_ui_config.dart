import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  TodoListUiConfig._();
  static const Color secondary = Color(0xfff0f3f7);
  static const Color secondaryDark = Color(0xff54749e);
  static const Color _primary = Color(0xff5c77ce);
  static const Color scaffoldBackgroundColor = Color(0xfffafbfe);
  static const Color scaffoldBackgroundColorDark = Color(0xff121212);
  static const Color _errorColor = Colors.red;
  static final Color? _primaryColorDark = Colors.grey[800];
  static final TextTheme _fontFamily = GoogleFonts.mandaliTextTheme();

  static ThemeData get lightTheme => ThemeData(
        primaryColor: _primary,
        brightness: Brightness.light,
        primaryColorLight: const Color(0xffabc8f7),
        primaryColorDark: _primaryColorDark,
        errorColor: _errorColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        dividerColor: Colors.grey,
        toggleableActiveColor: _primary,
        colorScheme: const ColorScheme.light(
          secondary: Colors.white,
          secondaryContainer: Color(0xfff0f3f7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: _primary),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _primary,
          foregroundColor: scaffoldBackgroundColor,
        ),
        textTheme: _fontFamily.copyWith(
          labelLarge: _fontFamily.labelLarge?.copyWith(
            color: _primaryColorDark,
          ),
          labelSmall: _fontFamily.labelLarge?.copyWith(
            color: _primaryColorDark,
          ),
          labelMedium: _fontFamily.labelLarge?.copyWith(
            color: _primaryColorDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 2,
              color: _primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: _errorColor,
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: _primary,
            systemNavigationBarContrastEnforced: true,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: _primary),
          titleTextStyle: TextStyle(color: _primary),
          backgroundColor: scaffoldBackgroundColor,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        primaryColor: _primary,
        brightness: Brightness.light,
        primaryColorLight: const Color(0xffabc8f7),
        primaryColorDark: _primaryColorDark,
        errorColor: _errorColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        dividerColor: Colors.grey,
        toggleableActiveColor: _primary,
        colorScheme: const ColorScheme.light(
          secondary: Colors.white,
          secondaryContainer: Color(0xfff0f3f7),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(primary: _primary),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _primary,
          foregroundColor: scaffoldBackgroundColor,
        ),
        textTheme: _fontFamily.copyWith(
          labelLarge: _fontFamily.labelLarge?.copyWith(
            color: _primaryColorDark,
          ),
          labelSmall: _fontFamily.labelLarge?.copyWith(
            color: _primaryColorDark,
          ),
          labelMedium: _fontFamily.labelLarge?.copyWith(
            color: _primaryColorDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade600,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade500,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              width: 2,
              color: _primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: _errorColor,
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
            // systemNavigationBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: _primary),
          titleTextStyle: TextStyle(color: _primary),
          backgroundColor: scaffoldBackgroundColor,
        ),
      );
}
