

import 'package:flutter/material.dart';

const int mobileSize = 600;
const int tabletSize = 1100;

class ResponsiveLayout extends StatelessWidget {
  // the custom screen size is specific to this project
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileSize;
  }

  static bool isTablet(BuildContext context) {
    final mq = MediaQuery.of(context).size.width;

    return mobileSize <= mq && mq <= tabletSize;
  }

  static bool isDesktop(BuildContext context) {
    final mq = MediaQuery.of(context).size.width;
    return mq >= tabletSize;
  }

  // static AppStyle get style => _style;
  // static AppStyle _style = AppStyle();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // _style = AppStyle(screenSize: context.mq);
        if (constraints.maxWidth < mobileSize) {
          return mobile;
        } else if (constraints.maxWidth < tabletSize) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
