import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:news_app/core/utils/constant/app_theme.dart';

import 'shared_pref_provider.dart';

final themeSwitchProvider = StateProvider<bool>((ref) {
  final pref = ref.watch(sharedPreferencesProvider);

  final theme = pref.value?.getString('themeMode');

  if (theme != null) {
    return theme == 'dark';
  }

  final platformBrightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  log('platformBrightness: $platformBrightness');

  return platformBrightness == Brightness.dark;
});

final themeModeProvider = StateProvider<ThemeData>((ref) {
  final pref = ref.watch(sharedPreferencesProvider);
  final isDarkMode = ref.watch(themeSwitchProvider);

  pref.value?.setString('themeMode', isDarkMode ? 'dark' : 'light');

  return isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
});
