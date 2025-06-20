import 'package:booklub/config/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeMode {
  light,
  dark,
  system;

  static ThemeMode fromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

}

class ThemeContext extends ChangeNotifier with WidgetsBindingObserver {

  static const String _themeModeKey = 'themeMode';

  final AppTheme _lightTheme;

  final AppTheme _darkTheme;

  AppTheme activeTheme;

  Brightness activeThemeType;

  ThemeMode themeMode = ThemeMode.system;

  ThemeContext({
    required lightTheme,
    required darkTheme
  }):
    activeTheme=lightTheme,
    activeThemeType=Brightness.light,
    _lightTheme=lightTheme,
    _darkTheme=darkTheme
  {
    WidgetsBinding.instance.addObserver(this);
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString(_themeModeKey) ?? '';

    switch(ThemeMode.fromString(savedThemeMode)) {
      case ThemeMode.light:
        setLightTheme();
        break;
      case ThemeMode.dark:
        setDarkTheme();
        break;
      default:
        setSystemTheme();
        break;
    }
  }

  @override
  void didChangePlatformBrightness() {
    if (themeMode != ThemeMode.system) return;
    setSystemTheme();
  }

  void setDarkTheme({bool save = false}) async {
    activeTheme = _darkTheme;
    activeThemeType = Brightness.dark;
    if (save) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_themeModeKey, ThemeMode.dark.toString());
    }
    notifyListeners();
  }

  void setLightTheme({bool save = false}) async {
    activeTheme = _lightTheme;
    activeThemeType = Brightness.light;
    if (save) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_themeModeKey, ThemeMode.light.toString());
    }
    notifyListeners();
  }

  void setSystemTheme({bool save = false}) async {
    activeThemeType = WidgetsBinding.instance.platformDispatcher.platformBrightness;

    switch(activeThemeType) {
      case Brightness.dark:
        setDarkTheme();
        break;
      case Brightness.light:
        setLightTheme();
        break;
    }

    if (save) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_themeModeKey, ThemeMode.system.toString());
    }
    notifyListeners();
  }

}