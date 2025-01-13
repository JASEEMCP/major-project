import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/application/common/theme_cubit/theme_cubit.dart';
import 'package:app/main.dart';
import 'package:app/styles/responsive_layout.dart';
import 'package:app/styles/theme.dart';

/// BuildContext
extension BuildContextX on BuildContext {
  Size get mq => MediaQuery.sizeOf(this);

  AppTheme get theme => watch<ThemeCubit>().appTheme;

  bool get isMobile => ResponsiveLayout.isMobile(this);
  bool get isTablet => ResponsiveLayout.isTablet(this);
  bool get isDesktop => ResponsiveLayout.isDesktop(this);

  void showCustomSnackBar(String content) =>
      ScaffoldMessenger.of(this).showSnackBar(showSnackBar(content));
  
}
/// String
extension StringStyling on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

SnackBar showSnackBar(String content) {
  return SnackBar(
    width: 380,
    dismissDirection: DismissDirection.down,
    duration: const Duration(milliseconds: 1400),
    elevation: 0,
    content: Center(
      child: Text(
        content,
        textScaler: const TextScaler.linear(1),
        textAlign: TextAlign.center,
        style: $style.text.textBold14,
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 144, 143, 145),
    behavior: SnackBarBehavior.floating,
  );
}