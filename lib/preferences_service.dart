// preferences_service.dart
//
// Practical 5 — Persistent User Preferences (Shared Preferences)
// -----------------------------------------------------------------
// A small service layer around the `shared_preferences` package.
// Keeping this in its own file (rather than scattering
// SharedPreferences calls across every screen) is what the practical
// means by a "modular navigation / storage structure".
//
// SharedPreferences stores simple key-value data (String, int, double,
// bool, List<String>) on the device disk, and it survives app restarts —
// unlike in-memory state, which resets every time the app is killed.
// It is NOT encrypted, so it should only be used for non-sensitive data
// such as login flags, display name, and UI preferences (never raw
// passwords) — see FlutterSecureStorage for anything sensitive.

import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart' show StudentSettings;

class PreferencesService {
  PreferencesService._(); // static-only class, never instantiated

  static const _kLoggedIn = 'isLoggedIn';
  static const _kUsername = 'username';
  static const _kEmail = 'email';

  static const _kDarkMode = 'darkMode';
  static const _kLanguage = 'language';
  static const _kSemester = 'semester';
  static const _kAssignmentAlerts = 'assignmentAlerts';
  static const _kExamNotifications = 'examNotifications';
  static const _kPlacementUpdates = 'placementUpdates';
  static const _kEventAnnouncements = 'eventAnnouncements';

  // ------------------------------------------------------------------
  // SESSION (login state)
  // ------------------------------------------------------------------

  /// Called right after a successful login/registration.
  static Future<void> saveSession({
    required String username,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLoggedIn, true);
    await prefs.setString(_kUsername, username);
    await prefs.setString(_kEmail, email);
  }

  /// Called on logout — wipes the session AND saved preferences, so the
  /// next person to open the app gets a clean Login screen.
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kLoggedIn) ?? false;
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUsername);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kEmail);
  }

  // ------------------------------------------------------------------
  // PREFERENCES (theme, language, semester, notifications)
  // ------------------------------------------------------------------

  /// Persists the fields of [settings] that should survive app restarts.
  static Future<void> savePreferences(StudentSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kDarkMode, settings.darkMode);
    await prefs.setString(_kLanguage, settings.language);
    await prefs.setString(_kSemester, settings.semester);
    await prefs.setBool(_kAssignmentAlerts, settings.assignmentAlerts);
    await prefs.setBool(_kExamNotifications, settings.examNotifications);
    await prefs.setBool(_kPlacementUpdates, settings.placementUpdates);
    await prefs.setBool(_kEventAnnouncements, settings.eventAnnouncements);
  }

  /// Mutates [settings] in place with any previously-saved values.
  /// Fields that were never saved keep their current (default) value.
  static Future<void> loadPreferencesInto(StudentSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    settings.darkMode = prefs.getBool(_kDarkMode) ?? settings.darkMode;
    settings.language = prefs.getString(_kLanguage) ?? settings.language;
    settings.semester = prefs.getString(_kSemester) ?? settings.semester;
    settings.assignmentAlerts =
        prefs.getBool(_kAssignmentAlerts) ?? settings.assignmentAlerts;
    settings.examNotifications =
        prefs.getBool(_kExamNotifications) ?? settings.examNotifications;
    settings.placementUpdates =
        prefs.getBool(_kPlacementUpdates) ?? settings.placementUpdates;
    settings.eventAnnouncements =
        prefs.getBool(_kEventAnnouncements) ?? settings.eventAnnouncements;

    final savedName = prefs.getString(_kUsername);
    if (savedName != null && savedName.isNotEmpty) {
      settings.name = savedName;
    }
  }
}