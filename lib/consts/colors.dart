import 'package:flutter/material.dart';

class Style {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        bottomNavigationBarTheme:
            Theme.of(context).bottomNavigationBarTheme.copyWith(
                  selectedItemColor: isDarkTheme
                      ? const Color(0xFF0ececec)
                      : const Color(0xFF00264D),
                  unselectedItemColor: isDarkTheme
                      ? const Color(0xFF8c8c8c)
                      : const Color(0xFF8c8c8c),
                  elevation: 0.0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
                ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              color: isDarkTheme
                  ? const Color(0xFF001B36)
                  : const Color(0xFFececec),
            ),
        scaffoldBackgroundColor:
            isDarkTheme ? const Color(0xFF001B36) : const Color(0xFFececec),
        primaryColor: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: isDarkTheme
                  ? const Color(0xFF1a1f3c)
                  : const Color(0xFFE8FDFD),
              brightness: isDarkTheme ? Brightness.dark : Brightness.light,
            ),
        cardColor:
            isDarkTheme ? const Color(0xFF0a0d2c) : const Color(0xFFF2FDFD),
        canvasColor:
            isDarkTheme ? const Color(0xFF001B36) : const Color(0xFFececec),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              colorScheme: isDarkTheme
                  ? const ColorScheme.dark()
                  : const ColorScheme.light(),
            ));
  }
}
