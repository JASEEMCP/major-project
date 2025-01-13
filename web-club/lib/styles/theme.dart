import 'package:flutter/material.dart';
import 'package:app/styles/colors.dart';

enum ThemeType {
  light,
  dark,
}

class AppTheme {
  static ThemeType defaultTheme = ThemeType.light;

  bool isDark;
  Color kBlack;
  Color kWhite;
  Color indigo;
  Color indigoLight;

  /// Default constructor
  AppTheme({
    required this.isDark,
    required this.kBlack,
    required this.kWhite,
    required this.indigo,
    required this.indigoLight,
  });

  /// fromType factory constructor
  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.light:
        return AppTheme(
          isDark: false,
          kBlack: AppColors.kBlack,
          kWhite: AppColors.kWhite,
          indigo: AppColors.indigo,
          indigoLight: AppColors.indigoLight,
        );

      case ThemeType.dark:
        return AppTheme(
          isDark: true,
          kBlack: AppColors.primaryDark,
          kWhite: AppColors.secondaryDark,
          indigo: AppColors.indigo,
          indigoLight: AppColors.indigoLight,
        );
    }
  }

  ThemeData get themeData {
    var t = ThemeData(
      useMaterial3: true,
    );
    return t.copyWith(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
