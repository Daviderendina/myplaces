import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: _LightColors().primary,
    disabledColor: _LightColors().inactiveItemColor,
    textTheme: _textLight,
    appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _LightColors().primary,
      unselectedItemColor: _LightColors().inactiveItemColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontSize: 13),
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(_LightColors().inputBackgroundColor),
      constraints: const BoxConstraints(minHeight: 0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(MainRadius.medium)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: _LightColors().inputBackgroundColor,
      hintStyle: TextStyle(color: _LightColors().inputTextHintColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static TextTheme get _textLight => const TextTheme(
    // headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
    // headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
    //headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black), // Page subtitle
    titleLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
    // Page titles
    // titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    titleSmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ), // Page subtitle
    // bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    // bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
    // labelLarge: TextStyle(
    //   fontSize: 14,
    //   fontWeight: FontWeight.w600,
    //   color: Colors.black,
    // ),
  );
}

class MainRadius {
  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;
}

abstract class MainColors {
  const MainColors();

  Color get primary;

  Color get inactiveItemColor;

  Color get inputBackgroundColor;

  Color get inputTextHintColor; // TODO valutare se farlo confluire in un valore piu generico
}

class _LightColors extends MainColors {
  const _LightColors();

  @override
  Color get primary => Colors.black;

  @override
  Color get inactiveItemColor => Color.fromARGB(100, 205, 205, 205);

  @override
  Color get inputBackgroundColor => Color.fromARGB(100, 227, 227, 227);

  @override
  Color get inputTextHintColor => Color.fromARGB(255, 170, 170, 170);
}
