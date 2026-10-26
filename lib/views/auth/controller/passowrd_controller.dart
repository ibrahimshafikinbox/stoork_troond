import 'package:flutter/material.dart';

class PasswordController extends ChangeNotifier {
  bool isSuccess = false;

  onSuccess() {
    isSuccess = true;
    notifyListeners();
  }

  updatePasswordInput() {
    notifyListeners();
  }
}
