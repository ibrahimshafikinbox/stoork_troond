import 'package:flutter/material.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  // await CategoriesServices().printDetailedCategoryReport();

  runApp(const MyApp());
}
