import 'package:flutter/cupertino.dart';

abstract class AppLayout {
  static final form = _FormLayout();

  // Get the padding for the fullscreen modal page
  static EdgeInsets getFullscreenModalPadding(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return EdgeInsets.fromLTRB(
      size.width * .05,
      size.height * 0.01,
      size.width * .05,
      size.height * 0.02,
    );
  }
}

class _FormLayout {
  // Form horizontal spacing
  final double _titleSpacingMultiplier = .029; // Space between the tiel and the rest of the form
  final double _subtitleSpacingMultiplier = .010; // Space between subtitle and the form input
  final double _fieldSpacingMultiplier = .023; // Space between field and the next subtitle

  // Form padding
  final double fieldInternalPaddingMultiplier = 0.015;

  double getTitleSpacing(BuildContext context) =>
      MediaQuery.of(context).size.height * _titleSpacingMultiplier;

  double getSubtitleSpacing(BuildContext context) =>
      MediaQuery.of(context).size.height * _subtitleSpacingMultiplier;

  double getFieldSpacing(BuildContext context) =>
      MediaQuery.of(context).size.height * _fieldSpacingMultiplier;

  EdgeInsets getFieldInternalMapping(BuildContext context) => EdgeInsets.symmetric(
    horizontal: MediaQuery.of(context).size.width * fieldInternalPaddingMultiplier,
  );
}
