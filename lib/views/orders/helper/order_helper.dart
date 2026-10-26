import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

// process/ in-delivery/ arriving/ success
// canceled

class OrderHelper {
  //* status
  static const String canceled = "Canceled";
  static const String pending = "Pending";
  static const String indelivered = "Indelivered";
  static const String delivered = "Delivered";
  static const String process = "Process";

  static Color getStatusOrder(String status) {
    switch (status) {
      case canceled:
        return AppColor.cFA4040;
      case delivered:
        return AppColor.c2AA952;
      case indelivered:
        return AppColor.main;
      case pending:
        return AppColor.main;
    }
    return AppColor.main;
  }
}
