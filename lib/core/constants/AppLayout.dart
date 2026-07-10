import 'package:flutter/cupertino.dart';

abstract class AppLayout {
  //TODO secondo me c'è da sistemare ancora qualcosa qui. Ad esempio, perchè ho un buttons ma anche un radius, se il radius è parametro del button?
  static late double screenHeight;
  static late double screenWidth;

  // Modules
  static final spaces = _Spaces();
  static final geometry = _Geometry();
  static final buttons = _Buttons();
  static final icons = _Icons();
  static final cards = _Cards();
  static final forms = _Forms();
  static final modals = _Modals();

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    screenHeight = size.height;
    screenWidth = size.width;

    spaces._init(screenHeight, screenWidth);
    geometry._init(screenHeight, screenWidth);
    buttons._init(screenHeight, screenWidth);
    icons._init(screenHeight, screenWidth);
    cards._init(screenHeight, screenWidth);
    forms._init(screenHeight, screenWidth);
    modals._init(screenHeight, screenWidth);
  }
}

class _Spaces {
  late double verticalSmall;
  late double verticalMedium;
  late double horizontalMedium;
  late double horizontalSmall;
  late double horizontalXSmall;

  void _init(double h, double w) {
    verticalSmall = h * .01;
    verticalMedium = h * .025;
    horizontalMedium = w * .055;
    horizontalSmall = w * .035;
    horizontalXSmall = w * .015;
  }
}

class _Geometry {
  late EdgeInsets mainPagePadding;
  late EdgeInsets untitledMainPagePadding;
  late double itemHeightSmall;
  final double radiusMedium = 12.0;
  final double radiusLarge = 20.0;

  void _init(double h, double w) {
    mainPagePadding = EdgeInsets.only(
      top: h * 0.06,
      left: w * 0.05,
      right: w * 0.05,
    );
    untitledMainPagePadding = EdgeInsets.fromLTRB(
      w * .05,
      h * 0.045,
      w * .05,
      h * 0.02,
    );

    itemHeightSmall = h * .06;
  }
}

class _Buttons {
  late double primaryHeight;
  late double circularXSmall;
  late double circularSmall;
  late double circularMedium;
  late double circularLarge;
  late double radiusSquare;

  void _init(double h, double w) {
    primaryHeight = h * 0.05;
    circularXSmall = h * .025;
    circularSmall = h * .038;
    circularMedium = h * .045;
    circularLarge = h * .055;
  }
}

class _Icons {
  late double xsmall;
  late double small;
  late double medium;
  late double large;
  late double emojiSmall;
  late double emojiMedium;

  void _init(double h, double w) {
    xsmall = h * .015;
    small = h * .02;
    medium = h * .03;
    large = h * .04;
    emojiSmall = h * .02;
    emojiMedium = h * .025;
  }
}

class _Cards {
  late double mapHeight;
  late double collectionHeight;
  late double collectionWidth;

  void _init(double h, double w) {
    mapHeight = h * 0.25;
    collectionHeight = h * .08;
    collectionWidth = w * .14;
  }
}

class _Forms {
  late double titleSpacing;
  late double subtitleSpacing;
  late double fieldSpacing;
  late EdgeInsets fieldInternalPadding;

  void _init(double h, double w) {
    titleSpacing = h * .029;
    subtitleSpacing = h * .010;
    fieldSpacing = h * .023;
    fieldInternalPadding = EdgeInsets.symmetric(horizontal: w * 0.015);
  }
}

class _Modals {
  late EdgeInsets fullscreenPadding; // TODO mettere insieme all altro pading
  late double bottomSheetRadius;
  late EdgeInsets bottomSheetPadding; // TODO mettere insieme all altro pading

  void _init(double h, double w) {
    fullscreenPadding = EdgeInsets.fromLTRB(
      w * .05,
      h * 0.01,
      w * .05,
      h * 0.02,
    );
    bottomSheetRadius = w * .08;
    bottomSheetPadding = EdgeInsets.only(
      top: h * 0.015,
      left: w * .01,
      right: w * .01,
    );
  }
}
