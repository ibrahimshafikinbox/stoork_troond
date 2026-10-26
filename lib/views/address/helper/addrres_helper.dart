import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class AddressHelper {
  static IconData getType(String type) {
    switch (type) {
      case "work":
        return BootstrapIcons.briefcase_fill;
      case "home":
        return BootstrapIcons.house;
      case "others":
        return Icons.place_rounded;
      default:
        return Icons.place_rounded;
    }
  }
}
