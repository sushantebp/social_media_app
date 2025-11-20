import 'package:flutter/material.dart';
import 'package:social_media_app/core/core.dart';

const Color seedColor = Colors.teal;

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: AppConstant.latoFont,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w800,
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 45,
      ),
      displaySmall: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 36,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      titleLarge: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: AppConstant.latoFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: seedColor.withValues(alpha: 0.3),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: seedColor);
        }
        return IconThemeData(color: Colors.grey.shade600);
      }),
    ),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Colors.black,
    fontFamily: AppConstant.latoFont,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w800,
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 45,
      ),
      displaySmall: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 36,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 28,
      ),
      headlineSmall: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
      titleLarge: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      titleSmall: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        fontFamily: AppConstant.latoFont,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      titleTextStyle: TextStyle(
        fontFamily: AppConstant.poppinsFont,
        fontWeight: FontWeight.w700,
        fontSize: 20,
      ),
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: AppConstant.latoFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: seedColor.withValues(alpha: 0.3),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: seedColor);
        }
        return IconThemeData(color: Colors.grey.shade400);
      }),
    ),
  );
}
