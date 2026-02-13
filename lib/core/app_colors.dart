import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF673AB7);
  static const Color primaryDark = Color(0xFF512DA8);
  static const Color primaryLight = Color(0xFF9575CD);

  static const Color accent = Color(0xFFAB47BC);
  static const Color accentLight = Color(0xFFBA68C8);

  static const Color foodColor = Color(0xFFFF6B6B);
  static const Color transportColor = Color(0xFF4ECDC4);
  static const Color shoppingColor = Color(0xFF9B59B6);
  static const Color entertainmentColor = Color(0xFFE91E63);
  static const Color billsColor = Color(0xFFFF5722);
  static const Color healthColor = Color(0xFF00BCD4);
  static const Color otherColor = Color(0xFF9E9E9E);

  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);

  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  static Map<String, Color> categoryColors = {
    'Food': foodColor,
    'Transport': transportColor,
    'Shopping': shoppingColor,
    'Entertainment': entertainmentColor,
    'Bills': billsColor,
    'Health': healthColor,
    'Other': otherColor,
  };

  static Map<String, IconData> categoryIcons = {
    'Food': Icons.restaurant,
    'Transport': Icons.directions_car,
    'Shopping': Icons.shopping_bag,
    'Entertainment': Icons.movie,
    'Bills': Icons.receipt,
    'Health': Icons.local_hospital,
    'Other': Icons.more_horiz,
  };
}