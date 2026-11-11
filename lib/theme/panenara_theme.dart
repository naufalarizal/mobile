import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PanenaraTheme {
  // Brand Colors
  static const Color primaryGreen = Color(0xFF258149);
  static const Color darkGreenBg = Color(0xFF1C3A2B);
  static const Color lightMint = Color(0xFFE6EFE3);
  static const Color goldAccent = Color(0xFFE8A33D);
  static const Color textWhite = Color(0xFFFDFFFE);
  static const Color textSubtle = Color(0xFFCFCFCF);
  static const Color textHint = Color(0xFF8B958E);
  static const Color textDark = Color(0xFF1C3A2B);
  static const Color inputBg = Colors.white;
  static const Color badgeGreenBg = Color(0xFFDCEBD8);

  // Gradient Background from Figma (3:52047)
  static const LinearGradient authGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF12331F), // 0%
      Color(0xFF1F5033), // 15%
      Color(0xFF2F774B), // 34%
      Color(0xFF2B6843), // 47%
      Color(0xFF255538), // 60%
      Color(0xFF1E3C2A), // 80%
      Color(0xFF1F3D2B), // 100%
    ],
    stops: [0.0, 0.15, 0.34, 0.47, 0.60, 0.80, 1.0],
  );

  // Box Shadows
  static const List<BoxShadow> inputShadow = [
    BoxShadow(
      color: Color(0x141E3C28),
      blurRadius: 5,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: Color(0x3312331F),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  // Text Styles
  static TextStyle get titleLarge => GoogleFonts.bricolageGrotesque(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: textWhite,
        letterSpacing: -0.26,
      );

  static TextStyle get subtitle => GoogleFonts.schibstedGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textSubtle,
        height: 1.45,
      );

  static TextStyle get fieldLabel => GoogleFonts.schibstedGrotesk(
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle get inputText => GoogleFonts.schibstedGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: textDark,
      );

  static TextStyle get inputHint => GoogleFonts.schibstedGrotesk(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: textHint,
      );

  static TextStyle get buttonText => GoogleFonts.schibstedGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.1,
      );

  static TextStyle get linkText => GoogleFonts.schibstedGrotesk(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle get bodySmall => GoogleFonts.schibstedGrotesk(
        fontSize: 12.5,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );
}
