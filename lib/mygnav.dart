import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//
// enum GnavStyle {
//   google,
//   oldSchool,
// }

class MyGNav extends StatefulWidget {
  const MyGNav({
    Key? key,
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabChange,
    this.gap = 0,
    this.padding = const EdgeInsets.all(25),
    this.activeColor,
    this.color,
    this.rippleColor = Colors.transparent,
    this.hoverColor = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.tabBackgroundColor = Colors.transparent,
    this.tabBorderRadius = 100.0,
    this.iconSize,
    this.textStyle,
    this.curve = Curves.easeInCubic,
    this.tabMargin = EdgeInsets.zero,
    this.debug = false,
    this.duration = const Duration(milliseconds: 500),
    this.tabBorder,
    this.tabActiveBorder,
    this.tabShadow,
    this.haptic = true,
    this.tabBackgroundGradient,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly, // TODO changed - prima era center
    this.style = GnavStyle.google,
    this.textSize,
  }) : super(key: key);

  final List<GButton> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTabChange;
  final double gap;
  final double tabBorderRadius;
  final double? iconSize;
  final Color? activeColor;
  final Color backgroundColor;
  final Color tabBackgroundColor;
  final Color? color;
  final Color rippleColor;
  final Color hoverColor;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry tabMargin;
  final TextStyle? textStyle;
  final Duration duration;
  final Curve curve;
  final bool debug;
  final bool haptic;
  final Border? tabBorder;
  final Border? tabActiveBorder;
  final List<BoxShadow>? tabShadow;
  final Gradient? tabBackgroundGradient;
  final MainAxisAlignment mainAxisAlignment;
  final GnavStyle? style;
  final double? textSize;

  @override
  _MyGNavState createState() => _MyGNavState();
}

class _MyGNavState extends State<MyGNav> {
  late int selectedIndex;
  bool clickable = true;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(MyGNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: widget.tabs
            .map(
              (t) => GButton(
                textSize: widget.textSize,
                style: widget.style,
                key: t.key,
                border: t.border ?? widget.tabBorder,
                activeBorder: t.activeBorder ?? widget.tabActiveBorder,
                shadow: t.shadow ?? widget.tabShadow,
                borderRadius:
                    t.borderRadius ??
                    BorderRadius.all(Radius.circular(widget.tabBorderRadius)),
                debug: widget.debug,
                margin: _calculateTabMargin(widget.tabMargin, widget.padding, selectedIndex, widget.tabs.indexOf(t), widget.tabs.length),
                active: selectedIndex == widget.tabs.indexOf(t),
                gap: t.gap ?? widget.gap,
                iconActiveColor: t.iconActiveColor ?? widget.activeColor,
                iconColor: t.iconColor ?? widget.color,
                iconSize: t.iconSize ?? widget.iconSize,
                textColor: t.textColor ?? widget.activeColor,
                rippleColor: t.rippleColor ?? widget.rippleColor,
                hoverColor: t.hoverColor ?? widget.hoverColor,
                padding: t.padding ?? widget.padding,
                textStyle: t.textStyle ?? widget.textStyle,
                text: t.text,
                icon: t.icon,
                haptic: widget.haptic,
                leading: t.leading,
                curve: widget.curve,
                backgroundGradient:
                    t.backgroundGradient ?? widget.tabBackgroundGradient,
                backgroundColor: t.backgroundColor ?? widget.tabBackgroundColor,
                duration: widget.duration,
                onPressed: () {
                  if (!clickable) return;
                  setState(() {
                    selectedIndex = widget.tabs.indexOf(t);
                    clickable = false;
                  });

                  t.onPressed?.call();

                  widget.onTabChange?.call(selectedIndex);

                  Future.delayed(widget.duration, () {
                    if (context.mounted) {
                      setState(() {
                        clickable = true;
                      });
                    }
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }

  EdgeInsetsGeometry? _calculateTabMargin(
      EdgeInsetsGeometry? margin,
      EdgeInsetsGeometry? padding,
      int? selectedIndex,
      int? tabIndex,
      int? tabsLength
      ) {

    final m = (margin ?? EdgeInsets.zero).resolve(TextDirection.ltr);
    final p = (padding ?? EdgeInsets.zero).resolve(TextDirection.ltr);

    bool isSelected = selectedIndex == tabIndex;
    bool isThisFirstTab = tabIndex == 0;
    bool isThisLastTab = tabIndex == (tabsLength! - 1);
    bool isFirstTabSelected = selectedIndex == 0;
    bool isLastTabSelected = selectedIndex == (tabsLength - 1);

    if (isSelected == false) {
      if (isFirstTabSelected || isLastTabSelected) {
        double marginMissingValue = p.left / (tabsLength * 2 - 3);

        return EdgeInsets.fromLTRB(
            isThisFirstTab ? m.left : m.left + marginMissingValue,
            m.top,
            isThisLastTab ? m.right : m.right + marginMissingValue,
            m.bottom
        );
      } else {
        return margin;
      }
    } else {
      return EdgeInsets.fromLTRB(
        isThisFirstTab ? m.left : m.left + p.left,
        m.top,
        isThisLastTab ? m.right : m.right + p.right,
        m.bottom,
      );
    }
  }



}
