import 'package:flutter/material.dart';

class AppMethod {
  Color hexToColor(String? code) {
    if (code == null || code.isEmpty) return Colors.white;
    try {
      String cleanHex = code.replaceAll("#", "");
      if (cleanHex.length >= 6) {
        return Color(int.parse(cleanHex.substring(0, 6), radix: 16) + 0xFF000000);
      }
    } catch (_) {}
    return Colors.white;
  }
}
