import 'package:flutter/material.dart';
import 'package:news_app/core/utils/constant/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      cardColor: Colors.white,
      scaffoldBackgroundColor: const Color(0xFFF6F3F7),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.black),
        trackColor: WidgetStateProperty.all(Colors.black.withOpacity(0.16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        suffixIconColor: AppColor.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColor.grey,
          ),
        ),
        hintStyle: const TextStyle(
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: AppColor.grey,
          ),
        ),
      ),
      primaryTextTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(
            color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(color: Colors.white, fontSize: 12),
        labelLarge: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(
            color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
        displaySmall: TextStyle(
            color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge: TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        titleMedium: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        titleSmall: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        bodyMedium: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
        labelLarge: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(
            color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(
            color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(Colors.black),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ));

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    cardColor: const Color(0xFF1F1F1F),
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      centerTitle: true,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.white),
      trackColor: WidgetStateProperty.all(Colors.white.withOpacity(0.16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      suffixIconColor: Colors.white.withOpacity(0.16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.16),
        ),
      ),
      hintStyle: const TextStyle(
        color: Colors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.16),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.black),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(
          color: Colors.black, fontSize: 28, fontWeight: FontWeight.w500),
      displaySmall: TextStyle(
          color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(color: Colors.black, fontSize: 12),
      labelLarge: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          color: Colors.black, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          color: Colors.black, fontSize: 10, fontWeight: FontWeight.w400),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
      displayMedium: TextStyle(
          color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
      displaySmall: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
      headlineLarge: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
      labelLarge: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
      labelMedium: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(
          color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400),
    ),
  );
}
