import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudyBuddyColors {
  static const background = Color(0xFFFFF4F5);
  static const paper = Color(0xFFFFFEFB);
  static const paperPink = Color(0xFFFFEAF0);
  static const blush = Color(0xFFF6B9C8);
  static const rose = Color(0xFFE98C9F);
  static const deepRose = Color(0xFF704348);
  static const butter = Color(0xFFF7D98F);
  static const paleButter = Color(0xFFFFEFCB);
  static const sage = Color(0xFFB9C99F);
  static const ink = Color(0xFF50383B);
  static const mutedInk = Color(0xFF9A777B);
  static const red = Color(0xFFF05A62);
}

ThemeData buildStudyBuddyTheme() {
  final body = GoogleFonts.nunito(
    color: StudyBuddyColors.ink,
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  final hand = GoogleFonts.patrickHand(
    color: StudyBuddyColors.ink,
    fontWeight: FontWeight.w700,
  );

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: StudyBuddyColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: StudyBuddyColors.rose,
      brightness: Brightness.light,
    ).copyWith(
      primary: StudyBuddyColors.deepRose,
      onPrimary: Colors.white,
      secondary: StudyBuddyColors.butter,
      surface: StudyBuddyColors.paper,
      onSurface: StudyBuddyColors.ink,
      error: StudyBuddyColors.red,
    ),
    fontFamily: GoogleFonts.nunito().fontFamily,
    textTheme: TextTheme(
      bodyLarge: body.copyWith(fontSize: 16),
      bodyMedium: body,
      bodySmall: body.copyWith(fontSize: 13, color: StudyBuddyColors.mutedInk),
      titleLarge: hand.copyWith(fontSize: 29),
      titleMedium: hand.copyWith(fontSize: 25),
      headlineSmall: hand.copyWith(fontSize: 34),
      headlineMedium: hand.copyWith(fontSize: 42),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: StudyBuddyColors.deepRose,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: hand.copyWith(fontSize: 31),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: StudyBuddyColors.paper,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      labelStyle: body.copyWith(color: StudyBuddyColors.mutedInk),
      hintStyle: body.copyWith(color: StudyBuddyColors.mutedInk),
      prefixIconColor: StudyBuddyColors.deepRose,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: StudyBuddyColors.blush, width: 1.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: StudyBuddyColors.blush, width: 1.4),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: StudyBuddyColors.rose, width: 2),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: StudyBuddyColors.deepRose,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w800),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: StudyBuddyColors.deepRose,
        textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w800),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: StudyBuddyColors.deepRose,
      foregroundColor: Colors.white,
    ),
    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: StudyBuddyColors.deepRose, width: 1.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      fillColor: WidgetStateProperty.resolveWith((states) =>
          states.contains(WidgetState.selected) ? StudyBuddyColors.deepRose : Colors.transparent),
      checkColor: WidgetStateProperty.all(Colors.white),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: StudyBuddyColors.ink,
      contentTextStyle: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w700),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: StudyBuddyColors.paper,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
  );
}
