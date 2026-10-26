import 'package:flutter/material.dart';
import 'package:troond/widget/bottom_sheet/lauguage_bottom_sheet.dart';

class CustomBottomSheet {
  //* language
  static showLanguage({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return const ChooseLangagueDailgo();
      },
    );
  }
}

