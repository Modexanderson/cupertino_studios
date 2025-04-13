import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as dart;
import '../utils/constants.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  // Cupertino theme setup
  static CupertinoThemeData cupertinoTheme({required bool isDark}) {
    return CupertinoThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: kPrimaryColor,
      barBackgroundColor:
          isDark ? kPrimaryDarkColor : CupertinoColors.systemBackground,
      scaffoldBackgroundColor:
          isDark ? kPrimaryDarkColor : CupertinoColors.systemBackground,
      textTheme: CupertinoTextThemeData(
        primaryColor: kPrimaryColor,
        textStyle: TextStyle(
          color: isDark ? kTextDarkColor : kTextLightColor,
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
        ),
        actionTextStyle: TextStyle(
          color: isDark ? kPrimaryLightColor : kPrimaryColor,
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
        ),
        navTitleTextStyle: TextStyle(
          color: isDark ? kTextDarkColor : kTextLightColor,
          fontSize: 17,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
        ),
      ),
    );
  }

  // Light theme setup
  static ThemeData lightTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      useMaterial3: true,
      cupertinoOverrideTheme: cupertinoTheme(isDark: false),
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: kPrimaryColor,
        cursorColor: kPrimaryColor,
        selectionColor: kPrimaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
        selectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: Colors.grey[600],
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: kSecondaryColor),
        hintStyle: TextStyle(color: kSecondaryColor.withOpacity(0.6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kSecondaryColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kSecondaryColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kDangerColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kDangerColor, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        iconColor: kPrimaryColor,
        textColor: Colors.black,
        tileColor: Colors.transparent,
        selectedTileColor: kPrimaryColor.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        collapsedIconColor: kPrimaryColor,
        iconColor: kPrimaryColor,
        textColor: kPrimaryColor,
        collapsedTextColor: Colors.black87,
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: kPrimaryColor.withOpacity(0.05),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // Fix for the AppBar theme where text is the same color as the background
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white, // This controls icon colors
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Explicitly set title text color
        ),
        // Add these properties to ensure all text in AppBar is properly visible
        toolbarTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 16,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
      ),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(8),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: kPrimaryColor.withOpacity(0.1),
        disabledColor: Colors.grey[300],
        selectedColor: kPrimaryColor,
        secondarySelectedColor: kPrimaryColor.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: Colors.black87,
        ),
        secondaryLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: kPrimaryColor,
        ),
        brightness: Brightness.light,
      ),
      disabledColor: Colors.grey[600],
      dividerColor: Colors.grey[300],
      brightness: Brightness.light,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Theme.of(context).cardColor,
        contentTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 14,
          color: Colors.black87,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: kPrimaryColor,
      ),
      indicatorColor: kPrimaryColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: kPrimaryColor,
        circularTrackColor: Colors.white,
        linearTrackColor: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.grey[900],
        opacity: 1.0,
        size: 24.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        indicatorColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: kPrimaryColor,
        inactiveTrackColor: kPrimaryColor.withOpacity(0.2),
        thumbColor: kPrimaryColor,
        overlayColor: kPrimaryColor.withOpacity(0.2),
        valueIndicatorColor: kPrimaryColor,
        valueIndicatorTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: Colors.white,
        ),
        trackHeight: 4.0,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey[700], // Medium-dark grey for light theme
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kPrimaryColor,
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          side: const BorderSide(color: kPrimaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: kPrimaryColor,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        tertiary: kAccentColor,
        error: kDangerColor,
        background: kBackgroundLightColor,
        surface: kSurfaceLightColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: Colors.black87,
        onSurface: Colors.black87,
        onError: Colors.white,
        brightness: Brightness.light,
      ).copyWith(),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      scaffoldBackgroundColor: kSurfaceLightColor,
    );
  }

  // Dark theme setup
  static ThemeData darkTheme({
    required BuildContext context,
  }) {
    return ThemeData(
      useMaterial3: true,
      cupertinoOverrideTheme: cupertinoTheme(isDark: true),
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey[300], // Light grey for dark theme
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionHandleColor: kPrimaryColor,
        cursorColor: kPrimaryColor,
        selectionColor: kPrimaryColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
        selectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: Colors.grey[500],
        ),
        backgroundColor: kPrimaryDarkColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: kPrimaryDarkColor,
        labelStyle: const TextStyle(color: kPrimaryLightColor),
        hintStyle: TextStyle(color: kPrimaryLightColor.withOpacity(0.6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kPrimaryLightColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: kPrimaryLightColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(width: 1.5, color: kPrimaryLightColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kDangerColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kDangerColor, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: kPrimaryDarkColor,
        modalBackgroundColor: kPrimaryDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: dart.Radius.circular(16),
            topRight: dart.Radius.circular(16),
          ),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: kPrimaryLightColor,
        textColor: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        tileColor: Colors.transparent,
        selectedTileColor: kPrimaryColor.withOpacity(0.2),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: kPrimaryLightColor,
        textColor: kPrimaryLightColor,
        collapsedTextColor: kPrimaryLightColor,
        collapsedIconColor: kPrimaryLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        backgroundColor: Colors.black.withOpacity(0.2),
        collapsedBackgroundColor: Colors.transparent,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: kPrimaryDarkColor,
        textStyle: const TextStyle(color: kPrimaryLightColor),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          return const TextStyle(color: kPrimaryLightColor);
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: kPrimaryDarkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: kPrimaryDarkColor,
        contentTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 14,
          color: kPrimaryLightColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        actionTextColor: kPrimaryColor,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: false,
      ),
      canvasColor: kPrimaryDarkColor,
      scaffoldBackgroundColor: kBackgroundDarkColor,
      drawerTheme: const DrawerThemeData(
        backgroundColor: kPrimaryDarkColor,
      ),
      cardColor: kPrimaryDarkColor,
      cardTheme: CardTheme(
        color: kSurfaceDarkColor,
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(8),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.black.withOpacity(0.3),
        disabledColor: Colors.grey[800],
        selectedColor: kPrimaryColor,
        secondarySelectedColor: kPrimaryColor.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: kPrimaryLightColor,
        ),
        secondaryLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: kPrimaryColor,
        ),
        brightness: Brightness.dark,
      ),
      dialogBackgroundColor: kPrimaryDarkColor,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: kPrimaryColor,
        circularTrackColor: kPrimaryDarkColor,
        linearTrackColor: kPrimaryDarkColor,
      ),
      iconTheme: const IconThemeData(
        color: kPrimaryLightColor,
        opacity: 1.0,
        size: 24.0,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      indicatorColor: kPrimaryColor,
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        indicatorColor: Colors.white,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: kPrimaryColor,
        inactiveTrackColor: Colors.grey.withOpacity(0.3),
        thumbColor: kPrimaryColor,
        overlayColor: kPrimaryColor.withOpacity(0.2),
        valueIndicatorColor: kPrimaryDarkColor,
        valueIndicatorTextStyle: TextStyle(
          fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
          fontSize: 12,
          color: kPrimaryLightColor,
        ),
        trackHeight: 4.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor,
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: kPrimaryLightColor,
          minimumSize: const Size(88, 48),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          side: const BorderSide(color: kPrimaryLightColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: kPrimaryColor,
        primary: kPrimaryColor,
        secondary: kSecondaryColor,
        tertiary: kAccentColor,
        error: kDangerColor,
        background: kBackgroundDarkColor,
        surface: kSurfaceDarkColor,
        onPrimary: kPrimaryLightColor,
        onSecondary: kPrimaryLightColor,
        onBackground: kPrimaryLightColor,
        onSurface: kPrimaryLightColor,
        onError: kPrimaryLightColor,
        brightness: Brightness.dark,
      ).copyWith(),
    );
  }

  // ADDITIONAL THEME UTILITIES

  // Text styles
  static TextStyle headingLarge({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: isDark ? kPrimaryLightColor : Colors.black87,
    );
  }

  static TextStyle headingMedium({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: isDark ? kPrimaryLightColor : Colors.black87,
    );
  }

  static TextStyle titleLarge({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: isDark ? kPrimaryLightColor : Colors.black87,
    );
  }

  static TextStyle titleMedium({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isDark ? kPrimaryLightColor : Colors.black87,
    );
  }

  static TextStyle bodyLarge({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: isDark ? kPrimaryLightColor : Colors.black87,
    );
  }

  static TextStyle bodyMedium({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: isDark ? kPrimaryLightColor : Colors.black87,
    );
  }

  static TextStyle bodySmall({bool isDark = false}) {
    return TextStyle(
      fontFamily: GoogleFonts.lato().fontFamily ?? 'SF Pro Display',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: isDark ? kPrimaryLightColor.withOpacity(0.8) : Colors.black54,
    );
  }

  // Card decorations
  static BoxDecoration standardCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      color: isDark ? kSurfaceDarkColor : Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration highlightCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      color: isDark ? kSurfaceDarkColor : Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(
        color: kPrimaryColor.withOpacity(0.3),
        width: 1.5,
      ),
    );
  }

  // Input decorations
  static InputDecoration standardInputDecoration({
    required String labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool isDark = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(
        color: isDark ? kPrimaryLightColor : kSecondaryColor,
      ),
      hintStyle: TextStyle(
        color: isDark
            ? kPrimaryLightColor.withOpacity(0.5)
            : kSecondaryColor.withOpacity(0.5),
      ),
      filled: true,
      fillColor: isDark ? kSurfaceDarkColor : Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: isDark
              ? kPrimaryLightColor.withOpacity(0.5)
              : kSecondaryColor.withOpacity(0.5),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: isDark
              ? kPrimaryLightColor.withOpacity(0.3)
              : kSecondaryColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: isDark ? kPrimaryLightColor : kPrimaryColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: kDangerColor,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: kDangerColor,
          width: 2,
        ),
      ),
    );
  }

  static InputDecoration searchInputDecoration({
    String hintText = "Search...",
    bool isDark = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: const Icon(Icons.search),
      prefixIconColor: isDark ? kPrimaryLightColor : kSecondaryColor,
      hintStyle: TextStyle(
        color: isDark
            ? kPrimaryLightColor.withOpacity(0.5)
            : kSecondaryColor.withOpacity(0.5),
      ),
      filled: true,
      fillColor:
          isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: isDark ? kPrimaryLightColor : kPrimaryColor,
          width: 1,
        ),
      ),
    );
  }

  // Button styles
  static ButtonStyle secondaryButtonStyle({bool isDark = false}) {
    return OutlinedButton.styleFrom(
      foregroundColor: isDark ? kPrimaryLightColor : kPrimaryColor,
      minimumSize: const Size(88, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      side: BorderSide(
        color: isDark ? kPrimaryLightColor : kPrimaryColor,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  static ButtonStyle textButtonStyle({bool isDark = false}) {
    return TextButton.styleFrom(
      foregroundColor: isDark ? Colors.grey[300] : Colors.grey[700],
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static ButtonStyle primaryButtonStyle({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(88, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
    );
  }

  static ButtonStyle dangerButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: kDangerColor,
      foregroundColor: Colors.white,
      minimumSize: const Size(88, 48),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Helper method to get current brightness
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  // Get theme-appropriate color based on dark mode
  static Color getThemeColor(
      BuildContext context, Color lightColor, Color darkColor) {
    return isDarkMode(context) ? darkColor : lightColor;
  }

  // Helper method to get theme-based text style
  static TextStyle getTextStyle(BuildContext context, String styleType) {
    final isDark = isDarkMode(context);

    switch (styleType) {
      case 'headingLarge':
        return headingLarge(isDark: isDark);
      case 'headingMedium':
        return headingMedium(isDark: isDark);
      case 'titleLarge':
        return titleLarge(isDark: isDark);
      case 'titleMedium':
        return titleMedium(isDark: isDark);
      case 'bodyLarge':
        return bodyLarge(isDark: isDark);
      case 'bodyMedium':
        return bodyMedium(isDark: isDark);
      case 'bodySmall':
        return bodySmall(isDark: isDark);
      default:
        return bodyMedium(isDark: isDark);
    }
  }

  // Helper method to get appropriate card decoration
  static BoxDecoration getCardDecoration(BuildContext context,
      {bool highlight = false}) {
    final isDark = isDarkMode(context);
    return highlight
        ? highlightCardDecoration(isDark: isDark)
        : standardCardDecoration(isDark: isDark);
  }

  // Helper method to get appropriate input decoration
  static InputDecoration getInputDecoration(
    BuildContext context, {
    required String labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    final isDark = isDarkMode(context);
    return standardInputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isDark: isDark,
    );
  }

  // Helper method to get search input decoration
  static InputDecoration getSearchInputDecoration(
    BuildContext context, {
    String hintText = "Search...",
  }) {
    final isDark = isDarkMode(context);
    return searchInputDecoration(
      hintText: hintText,
      isDark: isDark,
    );
  }

  // Status colors
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'active':
      case 'approved':
      case 'completed':
      case 'online':
        return kAccentColor;
      case 'warning':
      case 'pending':
      case 'processing':
      case 'in_progress':
        return kWarningColor;
      case 'error':
      case 'failed':
      case 'rejected':
      case 'canceled':
      case 'offline':
        return kDangerColor;
      default:
        return kSecondaryColor;
    }
  }

  // Shimmer effect colors
  static Color getShimmerBaseColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[800]! : Colors.grey[300]!;
  }

  static Color getShimmerHighlightColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[700]! : Colors.grey[100]!;
  }

  // Get appropriate text color based on background
  static Color getTextOnColor(Color backgroundColor) {
    // Calculate relative luminance
    double luminance = (0.299 * backgroundColor.red +
            0.587 * backgroundColor.green +
            0.114 * backgroundColor.blue) /
        255;

    // Return white for dark backgrounds, black for light
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  // Responsive spacing
  static double getResponsiveSpacing(BuildContext context, double spacingBase) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      return spacingBase * 0.8; // Smaller spacing for very small screens
    } else if (screenWidth > 600) {
      return spacingBase * 1.2; // Larger spacing for tablets/larger screens
    }
    return spacingBase;
  }

  // Avatar background colors (predictable based on string)
  static Color getAvatarColor(String identifier) {
    // Generate a predictable color based on the string
    final colors = [
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.amber[400]!,
      Colors.red[400]!,
      Colors.purple[400]!,
      Colors.teal[400]!,
      Colors.pink[400]!,
      Colors.orange[400]!,
    ];

    int hashCode = identifier.hashCode.abs();
    return colors[hashCode % colors.length];
  }

  // Get initials from name for avatar
  static String getInitials(String name) {
    if (name.isEmpty) return '';

    List<String> nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
    } else {
      return name[0].toUpperCase();
    }
  }
}
