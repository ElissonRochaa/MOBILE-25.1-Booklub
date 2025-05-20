import 'package:booklub/config/theme/app_theme.dart';
import 'package:booklub/config/theme/theme_context.dart';
import 'package:booklub/utils/theme/custom_colors.dart';
import 'package:flutter/material.dart';

abstract final class ThemeConfig {

  static TextTheme get _textTheme => TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 32,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 20
    ),
    labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16
    ),
    labelSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14
    ),
  );

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
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColors.white,
        elevation: 2,
        titleTextStyle: TextStyle(
          fontFamily: 'Navicula',
          color: CustomColors.violet,
          fontSize: 32,
          fontWeight: FontWeight.w400,
          shadows: [
            Shadow(
              color: CustomColors.black,
              blurRadius: 4,
              offset: Offset(-1, 1)
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: CustomColors.violet,
        ),
        shadowColor: CustomColors.black
      ),
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
      ),
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColors.black,
        elevation: 2,
        titleTextStyle: TextStyle(
          fontFamily: 'Navicula',
          color: CustomColors.lightVioletBlue,
          fontSize: 32,
          fontWeight: FontWeight.w400,
          shadows: [
            Shadow(
                color: CustomColors.black,
                blurRadius: 4,
                offset: Offset(-1, 1)
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: CustomColors.violet,
        ),
        shadowColor: CustomColors.black
      ),
    ),
  );

  static ThemeContext get themeContext => ThemeContext(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  );

}

extension ColorSchemeExtensions on ColorScheme {

  Color get black => CustomColors.black;

  Color get lightBlack => CustomColors.lightBlack;

  Color get superLightBlack => CustomColors.superLightBlack;

  Color get white => CustomColors.white;

  Color get darkWhite => CustomColors.darkWhite;

  Color get superDarkWhite => CustomColors.superDarkWhite;

}