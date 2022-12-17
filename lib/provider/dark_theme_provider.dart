import 'package:flutter/material.dart';

import '../services/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darktheme = false;

  bool get getDarkTheme => _darktheme;

  set setDarkTheme(bool value) {
    _darktheme = value;
    darkThemePrefs.setDarkTheme(bool, value);
    notifyListeners();
  }
}
