import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app/core/utils/constant/app_theme.dart';

import 'shared_pref_provider.dart';

enum ThemePreference { system, light, dark }

// Provider utama untuk menyimpan preferensi tema
final themePreferenceProvider =
    StateNotifierProvider<ThemePreferenceNotifier, ThemePreference>((ref) {
  return ThemePreferenceNotifier(ref);
});

class ThemePreferenceNotifier extends StateNotifier<ThemePreference> {
  final Ref ref;

  ThemePreferenceNotifier(this.ref) : super(ThemePreference.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final pref = ref.watch(sharedPreferencesProvider);
    final savedTheme = pref.value?.getString('themeMode');

    switch (savedTheme) {
      case 'light':
        state = ThemePreference.light;
        break;
      case 'dark':
        state = ThemePreference.dark;
        break;
      default:
        state = ThemePreference.system;
    }
  }

  void setTheme(ThemePreference preference) {
    final pref = ref.watch(sharedPreferencesProvider);
    state = preference;
    pref.value?.setString('themeMode', preference.name);
    _updateSystemUI(preference);
  }
}

// Provider untuk mengatur ThemeData berdasarkan tema yang dipilih
final themeModeProvider = Provider<ThemeData>((ref) {
  final themePreference = ref.watch(themePreferenceProvider);
  final platformBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  return switch (themePreference) {
    ThemePreference.light => AppTheme.lightTheme,
    ThemePreference.dark => AppTheme.darkTheme,
    ThemePreference.system => platformBrightness == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme,
  };
});

// Fungsi untuk mengupdate tampilan status bar dan navigation bar
void _updateSystemUI(ThemePreference themePreference) {
  final isDarkMode = themePreference == ThemePreference.dark ||
      (themePreference == ThemePreference.system &&
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:
        isDarkMode ? Colors.black : Colors.white, // Warna status bar
    statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
    systemNavigationBarColor: isDarkMode ? Colors.black : Colors.white,
    systemNavigationBarIconBrightness:
        isDarkMode ? Brightness.light : Brightness.dark,
  ));
}

// Provider untuk memeriksa apakah mode gelap aktif
final isDarkModeProvider = Provider<bool>((ref) {
  final themePreference = ref.watch(themePreferenceProvider);
  final platformBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  switch (themePreference) {
    case ThemePreference.light:
      return false;
    case ThemePreference.dark:
      return true;
    case ThemePreference.system:
      return platformBrightness == Brightness.dark;
  }
});
