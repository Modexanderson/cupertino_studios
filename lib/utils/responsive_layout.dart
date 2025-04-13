import 'package:flutter/material.dart';

/// A responsive layout widget that renders different widgets based on screen width.
///
/// This widget helps create responsive designs by showing different layouts
/// for mobile, tablet, and desktop views.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  /// Mobile breakpoint is less than 650
  /// Tablet breakpoint is between 650 and 1100
  /// Desktop breakpoint is greater than 1100
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 650) {
          return mobile;
        } else if (constraints.maxWidth < 1100) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}

/// Extension methods to help with responsive layouts
extension ResponsiveExtension on BuildContext {
  /// Returns true if the screen width is less than 650 pixels (mobile view)
  bool get isMobile => MediaQuery.of(this).size.width < 650;

  /// Returns true if the screen width is between 650 and 1100 pixels (tablet view)
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 650 &&
      MediaQuery.of(this).size.width < 1100;

  /// Returns true if the screen width is greater than 1100 pixels (desktop view)
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;
}
