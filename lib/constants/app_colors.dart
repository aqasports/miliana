import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF1e3a5f);
  static const secondary = Color(0xFF2c5aa0);
  static const accent = Color(0xFF4a90e2);
  static const gold = Color(0xFFd4af37);
  static const light = Color(0xFFF8FAFC);
  static const dark = Color(0xFF0f172a);
  static const gray = Color(0xFF64748b);

  static const gradient = LinearGradient(
    colors: [primary, accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // --- Backwards compatibility for older code ---
  static const deepBlue = primary;
  static const lightBlue = accent;
  static const cream = light;
  static const white = light;
  static const black = dark;
}
