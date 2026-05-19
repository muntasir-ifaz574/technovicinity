import 'package:flutter/material.dart';
import 'typography/app_text_theme.dart';
import 'colors/color_extensions.dart';
import 'colors/colors.dart';

part 'components/app_bar.dart';
part 'components/button.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    // Text theme
    fontFamily: "Roboto",
    textTheme: AppTextTheme.light,

    // Components
    appBarTheme: _appbarLightTheme,
    elevatedButtonTheme: _elevatedButtonLightTheme,

    // Colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.greyLight,
      error: AppColors.error,
    ),

    // extensions
    extensions: [
      AppExtraColors(
        success: AppColors.success,
        warning: AppColors.warning,
        error: AppColors.error,
      ),
    ],
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    // Text theme
    fontFamily: "Roboto",
    textTheme: AppTextTheme.dark,

    // Components
    appBarTheme: _appbarDarkTheme,

    // Colors
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.black,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.greyDark,
      error: AppColors.error,
    ),

    // extensions
    extensions: [
      AppExtraColors(
        success: AppColors.success,
        warning: AppColors.warning,
        error: AppColors.error,
      ),
    ],
  );
}
