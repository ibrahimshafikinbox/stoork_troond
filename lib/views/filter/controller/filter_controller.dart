// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:troond/views/filter/services/filter_services.dart';
import '../model/filter_model.dart';

class FilterController extends ChangeNotifier {
  FilterServices filterServices = FilterServices();
  String getString(List value) {
    return value.join(',');
  }

  List<int> categoryFilter = [];
  List<int> brandFilter = [];
  Future filter({
    required FilterModel filterModel,
    required BuildContext context,
  }) async {
    categoryFilter.clear();
    brandFilter.clear();
    for (var element in filterModel.categories) {
      if (element.isFilter == true) {
        categoryFilter.add(element.id);
      }
    }

    for (var element in filterModel.brands) {
      if (element.isFilter == true) {
        categoryFilter.add(element.id);
      }
    }
    notifyListeners();
    Navigator.pop(context);
  }

  Future getAllFilteredProducts() async {}
}
