import 'package:flutter/material.dart';

/// Manages user-controlled app-wide preferences: theme mode and locale.
///
/// Provided globally in [main.dart] so that [MaterialApp.router] can
/// watch it and rebuild when the theme or language changes.
///
/// Preferences are currently held in memory. Persist to SharedPreferences
/// in a follow-up task when needed.
class PreferenceNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('tr'); // Turkish default

  // ── Getters ─────────────────────────────────────────────────────────────────
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  // ── Actions ─────────────────────────────────────────────────────────────────
  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }
}
