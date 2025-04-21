import 'package:booklub/config/theme/app_theme.dart';
import 'package:booklub/utils/custom_colors.dart';
import 'package:flutter/material.dart';

abstract final class ThemeConfig {

  static AppTheme get lightTheme => AppTheme(
    themeData: ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: CustomColors.violet,
        onPrimary: CustomColors.white,
        secondary: CustomColors.violetBlue,
        onSecondary: CustomColors.darkWhite,
        error: CustomColors.red,
        onError: CustomColors.white,
        surface: CustomColors.white,
        onSurface: CustomColors.black,
      )
    ),
  );

  static AppTheme get darkTheme => AppTheme(
    themeData: ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: CustomColors.violet,
        onPrimary: CustomColors.white,
        secondary: CustomColors.violetBlue,
        onSecondary: CustomColors.darkWhite,
        error: CustomColors.red,
        onError: CustomColors.white,
        surface: CustomColors.lightBlack,
        onSurface: CustomColors.white,
      )
    ),
  );

}

extension ThemeDataExtension on ThemeData {

  Color get black => CustomColors.black;

  Color get lightBlack => CustomColors.lightBlack;

  Color get superLightBlack => CustomColors.superLightBlack;

  Color get white => CustomColors.white;

  Color get darkWhite => CustomColors.darkWhite;

  Color get superDarkWhite => CustomColors.superDarkWhite;

}