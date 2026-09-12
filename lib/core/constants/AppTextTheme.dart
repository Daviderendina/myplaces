import 'package:flutter/material.dart';
import 'AppColors.dart';

/*
  display: Main titles/subtitle
    large: dedicated to main page titles
    medium: dedicated to secondary pages and modals titles
    small: dedicated to primary and secondary pages subtitle

  headline: All text for dividing sections of the app
    large: primary sections in main pages
    medium: secondary sections in main pages / primary sections in main pages
    small: sections in secondary pages

  title: dedicated to card titles and lists
    large: the main title of a card
    medium: the single text of a list
    small: the subtitle of a card

  body: all body text
    medium: the generic text
    small: smaller and lighter text (eg. notes)

  label: dedicated to labels and buttons
    large: for buttons
    medium: for labels
    small:
  * */

extension AppTextThemeExtension on TextTheme {
  TextStyle? get hintText {
    final theme = this;
    if (theme is AppTextTheme) {
      return theme.hintText;
    }
    return null;
  }
}

class AppTextTheme extends TextTheme {
  final TextStyle? hintText;

  const AppTextTheme.light()
    : hintText = const TextStyle(color: AppColors.hintLight),
      super(
        displayMedium: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryTextLight,
        ),
        displaySmall: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextLight,
        ),
        headlineSmall: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextLight,
        ),
        titleMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryTextLight,
        ),
        bodyMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextLight,
        ),
        bodySmall: const TextStyle(
          fontSize: 13,
          height: 1.2,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryTextLight,
        ),
        labelLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.onPrimaryLight,
        ),
      );
}
