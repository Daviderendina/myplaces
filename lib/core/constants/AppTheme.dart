import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: _LightColors().primary,
      onPrimary: _LightColors().onPrimary,
      surfaceContainer: _LightColors().surfaceContainer,
      onSurfaceVariant: _LightColors().onSurfaceVariant,
    ),
    disabledColor: _LightColors().inactiveItemColor,
    textTheme: _textLight,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _LightColors().primary,
      unselectedItemColor: _LightColors().inactiveItemColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontSize: 13),
    ),
    searchBarTheme: SearchBarThemeData(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(
        _LightColors().inputBackgroundColor,
      ),
      constraints: const BoxConstraints(minHeight: 0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MainRadius.medium),
        ),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(MainRadius.small)),
      ),
      clipBehavior: Clip.antiAlias,
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

  static TextTheme get _textLight => TextTheme(
    displayLarge: const TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displaySmall: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    // Page subtitle
    // titleLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    // titleSmall: TextStyle(
    //   fontSize: 18,
    //   fontWeight: FontWeight.w400,
    //   color: Colors.black,
    // ), // Page subtitle
    // bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
    bodyMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: _LightColors().bodyTextColor,
    ),
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
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

  Color get onPrimary;

  Color get inactiveItemColor;

  Color get inputBackgroundColor;

  Color get inputTextHintColor;

  // TODO valutare se farlo confluire in un valore piu generico

  Color get bodyTextColor;

  Color get surfaceContainer;

  Color get onSurfaceVariant;
}

class _LightColors extends MainColors {
  const _LightColors();

  @override
  Color get primary => Colors.black;

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get inactiveItemColor => Color.fromARGB(100, 205, 205, 205);

  @override
  Color get inputBackgroundColor => Color.fromARGB(100, 227, 227, 227);

  @override
  Color get inputTextHintColor => Color.fromARGB(255, 170, 170, 170);

  @override
  Color get bodyTextColor => Color.fromARGB(255, 57, 57, 57);

  @override
  Color get surfaceContainer => Color.fromARGB(255, 221, 221, 221);

  @override
  Color get onSurfaceVariant => Color.fromARGB(255, 126, 126, 126);
}
