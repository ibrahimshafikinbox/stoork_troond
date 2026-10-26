import 'package:flutter/material.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/main_screen/services/main_services.dart';
import 'package:troond/widget/bottom_sheet/lauguage_bottom_sheet.dart';

import 'package:troond/config/app_const/shared_const.dart';
import '../../../data/shared_pref/shared_pref.dart';

class MainController extends ChangeNotifier {
  //* screens
  int index = 0;
  changeIndex(int value, BuildContext context) {
    index = value;
    notifyListeners();
  }

  //* category
  int activeCategories = 0;
  List<CategoryModel> newSubCategories = [];
  void changeCatgory(int value, List<CategoryModel> subCategories) {
    activeCategories = value;
    newSubCategories = subCategories;
    notifyListeners();
  }

  //* search
  TextEditingController productName = TextEditingController();
  MainServices mainServices = MainServices();
  void onSearch() {
    notifyListeners();
  }

  //* nav category
  int? navCategoryActive;

  chooseNavCategory(int? value) {
    navCategoryActive = value;
    notifyListeners();
  }

  //* language
  Language language =
      Language(name: 'English', code: 'en', nativeName: '', flag: '');
  chnageLangage(Language value) async {
    language = value;
    await SharedPref.setlanguage(language.code);
    await SharedPref.removeKey(SharedConsts.home);
    await SharedPref.removeKey(SharedConsts.categories);
    await SharedPref.removeKey(SharedConsts.parentCategories);
    await SharedPref.removeKey("getNavCategory");
    notifyListeners();
  }
}
