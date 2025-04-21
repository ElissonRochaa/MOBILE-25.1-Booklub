import 'package:booklub/config/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';

class ThemeContext extends ChangeNotifier {

  final AppTheme _lightTheme;

  final AppTheme _darkTheme;

  AppTheme activeTheme;

  Brightness activeThemeType;

  ThemeContext({
    required lightTheme,
    required darkTheme
  }):
    activeTheme=lightTheme,
    activeThemeType=Brightness.light,
    _lightTheme=lightTheme,
    _darkTheme=darkTheme;

  void setDarkTheme() {
    activeTheme = _darkTheme;
    activeThemeType = Brightness.dark;
    notifyListeners();
  }

  void setLightTheme() {
    activeTheme = _lightTheme;
    activeThemeType = Brightness.light;
    notifyListeners();
  }

}