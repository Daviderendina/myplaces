import 'package:flutter/cupertino.dart';

// TODO se questo venisse inizializzato una volta e vasta forse poi diventa piu veloce
abstract class AppLayout {
  static final form = _FormLayout();
  static final map = _Map();
  static final collection = _Collection();
  static final space = _Space();
  static final button = _Button();
  static final icon = _Icon();

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

  // TODO fare tutte in una classe a parte
  static double getSmallVerticalSpace(BuildContext context) =>
      MediaQuery.of(context).size.height * .01;

  static double getMediumVerticalSpace(BuildContext context) =>
      MediaQuery.of(context).size.height * .03;

  static EdgeInsets getPagePadding(BuildContext context) => EdgeInsets.only(
    top: MediaQuery.of(context).size.height * 0.03,
    left: MediaQuery.of(context).size.width * 0.05,
    right: MediaQuery.of(context).size.width * 0.05,
  );
}

abstract class _Radius {
  static final medium = 12.0;
}

class _Space {
  double getVerticalSmall(BuildContext context) =>
      MediaQuery.of(context).size.height * .01;

  double getVerticalMedium(BuildContext context) =>
      MediaQuery.of(context).size.height * .025;

  double getHorizontalMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * .055;

  double getHorizontalSmall(BuildContext context) =>
      MediaQuery.of(context).size.width * .035;

  double getHorizontalXSmall(BuildContext context) =>
      MediaQuery.of(context).size.width * .015;
}

class _FormLayout {
  // Form padding
  final double fieldInternalPaddingMultiplier = 0.015;

  double getTitleSpacing(BuildContext context) =>
      MediaQuery.of(context).size.height * .029;

  double getSubtitleSpacing(BuildContext context) =>
      MediaQuery.of(context).size.height * .010;

  double getFieldSpacing(BuildContext context) =>
      MediaQuery.of(context).size.height * .023;

  EdgeInsets getFieldInternalMapping(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.width * fieldInternalPaddingMultiplier,
      );
}

class _Map {
  double cardHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.25;

  double cardRadius(BuildContext context) => _Radius.medium;
}

class _Collection {
  final card = _CollectionCard();
}

class _CollectionCard {
  double height(BuildContext context) =>
      MediaQuery.of(context).size.height * .08;

  double width(BuildContext context) => MediaQuery.of(context).size.width * .14;
}

class _Button {
  double getLargeHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height * 0.05;
}

class _Icon {
  double getSmallSize(BuildContext context) =>
      MediaQuery.sizeOf(context).height * .020;
}
