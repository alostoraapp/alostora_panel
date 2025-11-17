import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized theme configuration for the application.
class AppTheme {
  // --- GENERAL --- //
  static const _buttonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );
  static const _buttonDensity = VisualDensity.standard;
  static final _buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );

  // --- LIGHT THEME --- //
  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    colors: const _LightColors(),
  );

  // --- DARK THEME --- //
  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    colors: const _DarkColors(),
  );

  // --- THEME BUILDER --- //
  static ThemeData _buildTheme({
    required Brightness brightness,
    required _AppThemeColors colors,
  }) {
    final baseTheme = ThemeData(brightness: brightness);
    final textTheme = GoogleFonts.interTextTheme(baseTheme.textTheme);

    return baseTheme.copyWith(
      primaryColor: colors.colorScheme.primary,
      scaffoldBackgroundColor: colors.scaffoldColor,
      textTheme: textTheme.apply(bodyColor: colors.textColor, displayColor: colors.textColor),

      // Color Scheme
      colorScheme: colors.colorScheme,

      // Icon Theme
      iconTheme: IconThemeData(color: colors.iconColor),

      // Component Themes
      appBarTheme: AppBarTheme(
        backgroundColor: colors.appBarColor,
        foregroundColor: colors.appBarForegroundColor,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: colors.appBarForegroundColor,
        ),
        iconTheme: IconThemeData(color: colors.appBarForegroundColor), // Ensure app bar icons match
      ),
      drawerTheme: DrawerThemeData(backgroundColor: colors.drawerColor),
      dialogTheme: DialogThemeData(backgroundColor: colors.dialogColor),
      cardTheme: CardThemeData(color: colors.cardColor),
      elevatedButtonTheme: _getElevatedButtonTheme(textTheme, colors),
      outlinedButtonTheme: _getOutlinedButtonTheme(colors),
      textButtonTheme: _getTextButtonTheme(),
      inputDecorationTheme: _getInputDecorationTheme(textTheme, colors),
      checkboxTheme: CheckboxThemeData(
        side: BorderSide(width: 1, color: colors.checkboxBorderColor),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: MaterialStateProperty.all(true),
        trackVisibility: MaterialStateProperty.all(true),
        trackColor: MaterialStateProperty.all(colors.scrollbarTrackColor),
        thumbColor: MaterialStateProperty.all(colors.scrollbarThumbColor),
        thickness: MaterialStateProperty.all(6),
        radius: const Radius.circular(24),
      ),
    );
  }

  // --- COMPONENT THEME HELPERS --- //

  static ElevatedButtonThemeData _getElevatedButtonTheme(TextTheme baseTextTheme, _AppThemeColors colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: _buttonPadding,
        visualDensity: _buttonDensity,
        shape: _buttonShape,
        backgroundColor: colors.colorScheme.primary,
        foregroundColor: colors.colorScheme.onPrimary,
        textStyle: baseTextTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  static OutlinedButtonThemeData _getOutlinedButtonTheme(_AppThemeColors colors) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: _buttonPadding,
        visualDensity: _buttonDensity,
        shape: _buttonShape,
        side: BorderSide(color: colors.colorScheme.primary),
        foregroundColor: colors.colorScheme.primary,
      ),
    );
  }

  static TextButtonThemeData _getTextButtonTheme() {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: _buttonPadding,
        visualDensity: _buttonDensity,
        shape: _buttonShape,
      ),
    );
  }

  static InputDecorationTheme _getInputDecorationTheme(
    TextTheme textTheme,
    _AppThemeColors colors,
  ) {
    OutlineInputBorder border({Color? color}) {
      return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(width: 1, color: color ?? colors.inputBorderColor),
      );
    }

    return InputDecorationTheme(
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
      isDense: true,
      isCollapsed: true,
      enabledBorder: border(),
      focusedBorder: border(color: colors.colorScheme.primary),
      errorBorder: border(color: colors.colorScheme.error),
      focusedErrorBorder: border(color: colors.colorScheme.error),
      disabledBorder: border(),
      floatingLabelStyle: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      hintStyle: textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.normal,
        color: colors.hintColor,
      ),
    );
  }
}

// --- COLOR ABSTRACTION --- //

abstract class _AppThemeColors {
  Color get scaffoldColor;
  Color get textColor;
  Color get iconColor;
  Color get cardColor;
  Color get appBarColor;
  Color get appBarForegroundColor;
  Color get drawerColor;
  Color get dialogColor;
  Color get inputBorderColor;
  Color get hintColor;
  Color get checkboxBorderColor;
  Color get scrollbarTrackColor;
  Color get scrollbarThumbColor;
  ColorScheme get colorScheme;

  const _AppThemeColors();
}

class _LightColors implements _AppThemeColors {
  const _LightColors();

  @override
  ColorScheme get colorScheme => const ColorScheme.light(
        surface: AppColors.kNeutral50,
        primary: AppColors.kPrimary600,
        onPrimary: AppColors.kWhiteColor,
        secondary: AppColors.kNeutral200,
        error: AppColors.kError,
        primaryContainer: AppColors.kWhiteColor,
        onPrimaryContainer: AppColors.kNeutral900,
        tertiaryContainer: AppColors.kNeutral50,
        onTertiaryContainer: AppColors.kNeutral700,
        onTertiary: AppColors.kNeutral700,
        outline: AppColors.kNeutral300,
      );

  @override
  Color get scaffoldColor => AppColors.kNeutral50;
  @override
  Color get cardColor => AppColors.kWhiteColor;
  @override
  Color get textColor => AppColors.kNeutral900;
  @override
  Color get iconColor => AppColors.kNeutral700;
  @override
  Color get appBarColor => AppColors.kWhiteColor;
  @override
  Color get appBarForegroundColor => AppColors.kNeutral900;
  @override
  Color get drawerColor => AppColors.kWhiteColor;
  @override
  Color get dialogColor => AppColors.kWhiteColor;
  @override
  Color get inputBorderColor => AppColors.kNeutral300;
  @override
  Color get hintColor => AppColors.kNeutral700;
  @override
  Color get checkboxBorderColor => AppColors.kNeutral500;
  @override
  Color get scrollbarTrackColor => AppColors.kNeutral200;
  @override
  Color get scrollbarThumbColor => AppColors.kWhiteColor;
}

class _DarkColors implements _AppThemeColors {
  const _DarkColors();

  @override
  ColorScheme get colorScheme => const ColorScheme.dark(
        surface: AppColors.kDarkSurface,
        primary: AppColors.kPrimary600,
        onPrimary: AppColors.kWhiteColor,
        error: AppColors.kError,
        primaryContainer: AppColors.kDarkCard,
        onPrimaryContainer: AppColors.kWhiteColor,
        secondary: AppColors.kNeutral200,
        outline: AppColors.kNeutral600,
        onTertiary: AppColors.kNeutral200,
        tertiaryContainer: AppColors.kDarkCard,
        onTertiaryContainer: AppColors.kNeutral200,
      );

  @override
  Color get scaffoldColor => AppColors.kDarkSurface;
  @override
  Color get cardColor => AppColors.kDarkCard;
  @override
  Color get textColor => AppColors.kWhiteColor;
  @override
  Color get iconColor => AppColors.kWhiteColor; // Default white for dark mode
  @override
  Color get appBarColor => AppColors.kDarkCard;
  @override
  Color get appBarForegroundColor => AppColors.kWhiteColor;
  @override
  Color get drawerColor => AppColors.kDarkSidebar;
  @override
  Color get dialogColor => AppColors.kDarkCard;
  @override
  Color get inputBorderColor => AppColors.kNeutral600;
  @override
  Color get hintColor => AppColors.kNeutral200;
  @override
  Color get checkboxBorderColor => AppColors.kNeutral400;
  @override
  Color get scrollbarTrackColor => AppColors.kNeutral900;
  @override
  Color get scrollbarThumbColor => AppColors.kNeutral700;
}
