import 'package:flutter/material.dart';
import 'package:quit_smart_app/ui/theme/color_palette.dart';
import 'package:quit_smart_app/ui/theme/ui_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // --- Static Styles --- 
  
  // AppBar Actions Text Style
  static TextStyle get appBarActionTextStyle => GoogleFonts.inter(
        color: ColorPalette.textSecondary,
        fontSize: 14, // Example size, adjust as needed
      );

  // Footer Text Style
  static TextStyle get footerTextStyle => GoogleFonts.inter(
        color: ColorPalette.textSecondary,
        fontSize: 12, // Example size, adjust as needed
      );

  // Primary Elevated Button Style
  static ButtonStyle get primaryElevatedButtonStyle => ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        backgroundColor: ColorPalette.baseWhite900, // Use closest palette color
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CardConstants.cardBorderRadius), // Reuse card radius
        ),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
      );

  // Secondary Outlined Button Style
  static ButtonStyle get secondaryOutlinedButtonStyle => OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        foregroundColor: ColorPalette.textSecondary,
        side: const BorderSide(color: ColorPalette.grey300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CardConstants.cardBorderRadius), // Reuse card radius
        ),
        textStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500),
      );
  // --- End Static Styles --- 

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: ColorPalette.baseWhite, // Set scaffold background
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: false, // Align title left
      titleTextStyle: GoogleFonts.inter( // Use theme text style
        fontSize: 20, 
        fontWeight: FontWeight.w600,
        color: ColorPalette.baseContent, // Ensure title color contrasts
      ),
      // Note: actions use Text widgets, so style them directly using appBarActionTextStyle
    ),
    cardTheme: CardTheme(
      elevation: 2,
      margin: const EdgeInsets.all(CardConstants.cardPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CardConstants.cardBorderRadius),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryElevatedButtonStyle, // Set default elevated button style
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: secondaryOutlinedButtonStyle, // Set default outlined button style
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Colors.white,
      elevation: 1,
      // Padding is handled by the widget inside usually
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: ColorPalette.primary,
      onPrimary: ColorPalette.primaryContent,
      secondary: ColorPalette.secondary,
      onSecondary: ColorPalette.secondaryContent,
      tertiary: ColorPalette.accent,
      onTertiary: ColorPalette.accentContent,
      error: ColorPalette.error,
      onError: ColorPalette.errorContent,
      surface: ColorPalette.baseWhite,
      onSurface: ColorPalette.baseContent,
    ),
    textTheme: GoogleFonts.interTextTheme(),
  );
}
