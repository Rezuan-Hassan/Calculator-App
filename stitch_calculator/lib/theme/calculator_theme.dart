import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StitchColors {
  // Canvas & Surfaces
  static const Color surface = Color(0xFFFAF8FF);
  static const Color surfaceDim = Color(0xFFD2D9F4);
  static const Color surfaceBright = Color(0xFFFAF8FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF2F3FF);
  static const Color surfaceContainer = Color(0xFFEAEDFF);
  static const Color surfaceContainerHigh = Color(0xFFE2E7FF);
  static const Color surfaceContainerHighest = Color(0xFFDAE2FD);

  // Content / Neutrals
  static const Color onSurface = Color(0xFF131B2E);
  static const Color onSurfaceVariant = Color(0xFF464555);
  static const Color outline = Color(0xFF777587);
  static const Color outlineVariant = Color(0xFFC7C4D8);

  // Primary (Indigo Logic & CTA)
  static const Color primary = Color(0xFF3525CD);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF4F46E5);
  static const Color onPrimaryContainer = Color(0xFFDAD7FF);
  static const Color primaryFixed = Color(0xFFE2DFFF);
  static const Color onPrimaryFixed = Color(0xFF0F0069);
  static const Color primaryFixedDim = Color(0xFFC3C0FF);

  // Secondary
  static const Color secondary = Color(0xFF4648D4);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF6063EE);
  static const Color onSecondaryContainer = Color(0xFFFFFBFF);
  static const Color secondaryFixed = Color(0xFFE1E0FF);
  static const Color onSecondaryFixedVariant = Color(0xFF2F2EBE);

  // Destructive / Tertiary
  static const Color tertiary = Color(0xFF95002B);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFBF0F3C);
  static const Color tertiaryFixed = Color(0xFFFFDADB);
  static const Color onTertiaryFixedVariant = Color(0xFF92002A);

  // Shadows using modern Color.fromARGB
  static const List<BoxShadow> restingKeyShadow = [
    BoxShadow(
      color: Color.fromARGB(10, 15, 23, 42),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
    BoxShadow(
      color: Color.fromARGB(15, 15, 23, 42),
      offset: Offset(0, 6),
      blurRadius: 12,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> pressedKeyShadow = [
    BoxShadow(
      color: Color.fromARGB(13, 15, 23, 42),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const List<BoxShadow> primaryCtaShadow = [
    BoxShadow(
      color: Color.fromARGB(102, 53, 37, 205),
      offset: Offset(0, 8),
      blurRadius: 20,
      spreadRadius: -4,
    ),
  ];

  static const List<BoxShadow> primaryCtaPressedShadow = [
    BoxShadow(
      color: Color.fromARGB(64, 53, 37, 205),
      offset: Offset(0, 2),
      blurRadius: 6,
    ),
  ];

  static const List<BoxShadow> operatorKeyShadow = [
    BoxShadow(
      color: Color.fromARGB(31, 53, 37, 205),
      offset: Offset(0, 3),
      blurRadius: 8,
    ),
  ];

  static const List<BoxShadow> cardInsetShadow = [
    BoxShadow(
      color: Color.fromARGB(8, 19, 27, 46),
      offset: Offset(0, 2),
      blurRadius: 6,
    ),
  ];
}

class StitchTypography {
  static TextStyle displayLg({Color color = StitchColors.onSurface}) =>
      GoogleFonts.robotoFlex(
        fontSize: 56,
        fontWeight: FontWeight.w300,
        height: 64 / 56,
        letterSpacing: -1.1,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle displayMobile({Color color = StitchColors.onSurface}) =>
      GoogleFonts.robotoFlex(
        fontSize: 38,
        fontWeight: FontWeight.w500,
        height: 46 / 38,
        letterSpacing: -0.8,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle displayMd({Color color = StitchColors.onSurface}) =>
      GoogleFonts.robotoFlex(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 36 / 28,
        letterSpacing: -0.5,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle keypadLabel({Color color = StitchColors.onSurface}) =>
      GoogleFonts.robotoFlex(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle keypadLabelSm({Color color = StitchColors.onSurface}) =>
      GoogleFonts.robotoFlex(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle bodyLg({Color color = StitchColors.onSurfaceVariant}) =>
      GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        color: color,
        fontFeatures: const [FontFeature.tabularFigures()],
      );

  static TextStyle bodyMd({Color color = StitchColors.onSurfaceVariant}) =>
      GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: color,
      );

  static TextStyle labelMd({Color color = StitchColors.onSurfaceVariant}) =>
      GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        color: color,
      );

  static TextStyle titleLg({Color color = StitchColors.onSurface}) =>
      GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color,
      );
}
