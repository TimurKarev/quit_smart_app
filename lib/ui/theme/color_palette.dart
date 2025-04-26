import 'dart:ui';

class ColorPalette {
  ColorPalette._();

  static const Color baseWhite = Color(0xFFFFFFFF);
  static const Color baseWhite50 = Color(0xFFF9FAFB);
  static const Color baseWhite100 = Color(0xFFF3F4F6);
  static const Color baseWhite200 = Color(0xFFE5E7EB);
  static const Color baseWhite300 = Color(0xFFD1D5DB);
  static const Color baseWhite400 = Color(0xFF9CA3AF);
  static const Color baseWhite500 = Color(0xFF6B7280);
  static const Color baseWhite600 = Color(0xFF4B5563);
  static const Color baseWhite700 = Color(0xFF374151);
  static const Color baseWhite800 = Color(0xFF1F2937);
  static const Color baseWhite900 = Color(0xFF111827);
  static const Color baseContent = Color(0xFF1F2937);

  // Specific UI Element Colors (Additions)
  static const Color textSecondary = Color(0xFF757575); // Equivalent to Colors.grey[600]
  static const Color grey300 = Color(0xFFE0E0E0);      // Equivalent to Colors.grey[300]
  // ---

  static const Color primary = Color(0xFF3B82F6);
  static const Color primary50 = Color(0xFFEFF6FF);
  static const Color primary100 = Color(0xFFDBEAFE);
  static const Color primary200 = Color(0xFFBFDBFE);
  static const Color primary300 = Color(0xFF93C5FD);
  static const Color primary400 = Color(0xFF60A5FA);
  static const Color primary500 = Color(0xFF3B82F6);
  static const Color primary600 = Color(0xFF2563EB);
  static const Color primary700 = Color(0xFF1D4ED8);
  static const Color primary800 = Color(0xFF1E40AF);
  static const Color primary900 = Color(0xFF1E3A8A);
  static const Color primaryFocus = Color(0xFF2563EB);
  static const Color primaryContent = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF8B5CF6);
  static const Color secondary50 = Color(0xFFF5F3FF);
  static const Color secondary100 = Color(0xFFEDE9FE);
  static const Color secondary200 = Color(0xFFDDD6FE);
  static const Color secondary300 = Color(0xFFC4B5FD);
  static const Color secondary400 = Color(0xFFA78BFA);
  static const Color secondary500 = Color(0xFF8B5CF6);
  static const Color secondary600 = Color(0xFF7C3AED);
  static const Color secondary700 = Color(0xFF6D28D9);
  static const Color secondary800 = Color(0xFF5B21B6);
  static const Color secondary900 = Color(0xFF4C1D95);
  static const Color secondaryFocus = Color(0xFF7C3AED);
  static const Color secondaryContent = Color(0xFFFFFFFF);

  static const Color accent = Color(0xFFF472B6);
  static const Color accent50 = Color(0xFFFDF2F8);
  static const Color accent100 = Color(0xFFFCE7F3);
  static const Color accent200 = Color(0xFFFBCFE8);
  static const Color accent300 = Color(0xFFF9A8D4);
  static const Color accent400 = Color(0xFFF472B6);
  static const Color accent500 = Color(0xFFEC4899);
  static const Color accent600 = Color(0xFFDB2777);
  static const Color accent700 = Color(0xFFBE185D);
  static const Color accent800 = Color(0xFF9D174D);
  static const Color accent900 = Color(0xFF831843);
  static const Color accentFocus = Color(0xFFDB2777);
  static const Color accentContent = Color(0xFFFFFFFF);

  static const Color neutral = Color(0xFF6B7280);
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);
  static const Color neutralFocus = Color(0xFF4B5563);
  static const Color neutralContent = Color(0xFFFFFFFF);

  static const Color info = Color(0xFF3B82F6);
  static const Color info50 = Color(0xFFEFF6FF);
  static const Color info100 = Color(0xFFDBEAFE);
  static const Color info200 = Color(0xFFBFDBFE);
  static const Color info300 = Color(0xFF93C5FD);
  static const Color info400 = Color(0xFF60A5FA);
  static const Color info500 = Color(0xFF3B82F6);
  static const Color info600 = Color(0xFF2563EB);
  static const Color info700 = Color(0xFF1D4ED8);
  static const Color info800 = Color(0xFF1E40AF);
  static const Color info900 = Color(0xFF1E3A8A);
  static const Color infoFocus = Color(0xFF2563EB);
  static const Color infoContent = Color(0xFFFFFFFF);

  static const Color success = Color(0xFF10B981);
  static const Color success50 = Color(0xFFECFDF5);
  static const Color success100 = Color(0xFFD1FAE5);
  static const Color success200 = Color(0xFFA7F3D0);
  static const Color success300 = Color(0xFF6EE7B7);
  static const Color success400 = Color(0xFF34D399);
  static const Color success500 = Color(0xFF10B981);
  static const Color success600 = Color(0xFF059669);
  static const Color success700 = Color(0xFF047857);
  static const Color success800 = Color(0xFF065F46);
  static const Color success900 = Color(0xFF064E3B);
  static const Color successFocus = Color(0xFF059669);
  static const Color successContent = Color(0xFFFFFFFF);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warning50 = Color(0xFFFFFBEB);
  static const Color warning100 = Color(0xFFFEF3C7);
  static const Color warning200 = Color(0xFFFDE68A);
  static const Color warning300 = Color(0xFFFCD34D);
  static const Color warning400 = Color(0xFFFBBF24);
  static const Color warning500 = Color(0xFFF59E0B);
  static const Color warning600 = Color(0xFFD97706);
  static const Color warning700 = Color(0xFFB45309);
  static const Color warning800 = Color(0xFF92400E);
  static const Color warning900 = Color(0xFF78350F);
  static const Color warningFocus = Color(0xFFD97706);
  static const Color warningContent = Color(0xFFFFFFFF);

  static const Color error = Color(0xFFEF4444);
  static const Color error50 = Color(0xFFFEF2F2);
  static const Color error100 = Color(0xFFFEE2E2);
  static const Color error200 = Color(0xFFFECACA);
  static const Color error300 = Color(0xFFFCA5A5);
  static const Color error400 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444);
  static const Color error600 = Color(0xFFDC2626);
  static const Color error700 = Color(0xFFB91C1C);
  static const Color error800 = Color(0xFF991B1B);
  static const Color error900 = Color(0xFF7F1D1D);
  static const Color errorFocus = Color(0xFFDC2626);
  static const Color errorContent = Color(0xFFFFFFFF);
}
