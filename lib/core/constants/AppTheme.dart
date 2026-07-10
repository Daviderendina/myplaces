import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppColors.dart';
import 'package:myplaces/core/constants/AppTextTheme.dart';

import 'AppLayout.dart';

class AppTheme {
  static double get surfaceAlpha => 0.8;

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryLight,
      onPrimary: AppColors.onPrimaryLight,
      surface: Colors.white,
      surfaceContainer: AppColors.surfaceContainerLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
    ),
    disabledColor: AppColors.disabledLight,
    textTheme: const AppTextTheme.light(),
    hintColor: AppColors.hintLight,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white.withValues(alpha: AppTheme.surfaceAlpha),
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.disabledLight,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontSize: 13),
    ),
    searchBarTheme: SearchBarThemeData(
      // SearchBar generica nell'app
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(
        AppColors.scaffoldBackgroundLight,
      ),
      constraints: const BoxConstraints(minHeight: 0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.geometry.radiusMedium),
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppLayout.geometry.radiusMedium),
      ),
      clipBehavior: Clip.antiAlias,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      filled: true,
      fillColor: AppColors.inputBackgroundContainer,
      hintStyle: const TextStyle(color: AppColors.hintLight),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
