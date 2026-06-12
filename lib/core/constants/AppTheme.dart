import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: _LightColors().primary,
    textTheme: _textLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _LightColors().primary,
      unselectedItemColor: _LightColors().inactiveItemColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 13),
    ),
  );

  static TextTheme get _textLight => const TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
    // TODO da rivedere
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    // TODO da rivedere
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
    // TODO da rivedere
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
    // TODO da rivedere
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    // TODO da rivedere
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    // TODO da rivedere
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    // TODO da rivedere
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ), // TODO da rivedere
  );
}

abstract class MainColors {
  const MainColors();

  Color get primary;

  Color get inactiveItemColor;
}

class _LightColors extends MainColors {
  const _LightColors();

  @override
  Color get primary => Colors.black;

  @override
  Color get inactiveItemColor => Color.fromARGB(100, 205, 205, 205);
}
