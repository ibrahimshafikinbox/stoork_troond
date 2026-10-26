import 'package:queen_validators/queen_validators.dart';

class AppValidation {
  static String? Function(String?)? name() {
    return qValidator([
      IsRequired("Required"),
      MinLength(4, "Minimum 4 characters"),
    ]);
  }

  static String? Function(String?)? phone() {
    return qValidator([
      IsRequired("Required"),
      IsNumber(),
    ]);
  }

  static String? Function(String?)? required() {
    return qValidator([
      IsRequired("Required"),
    ]);
  }

  static String? Function(String?)? email() {
    return qValidator([
      IsRequired("Required"),
      const IsEmail("You must enter a valid email address"),
    ]);
  }

  static String? Function(String?)? password() {
    return qValidator([
      IsRequired("Required"),
      MinLength(6, "Minimum 6 characters"),
    ]);
  }
}
