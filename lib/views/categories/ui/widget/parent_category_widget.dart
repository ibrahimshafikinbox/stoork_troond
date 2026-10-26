import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/widget/category/category_group_widget.dart';
import 'package:troond/widget/loading/loading_widget.dart';

class ParentCaregoryWidget extends StatelessWidget {
  const ParentCaregoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: CategoriesServices().getParentCategories(),
      builder: (context, snapshot) {
        var cache = SharedPref.getKey(key: SharedConsts.parentCategories);
        if (cache == null) {
          return const LoadingWidget();
        } else {
          var data = jsonDecode(cache);
          List<CategoryModel> categoriesList = [];
          for (var element in data["data"]) {
            categoriesList.add(CategoryModel.fromJson(element));
          }
          var result = snapshot.hasData ? snapshot.data! : categoriesList;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: result.length,
            itemBuilder: (context, index) {
              var item = result[index];
              return CategoryGroupWidget(categoryModel: item);
            },
          );
        }
      },
    );
  }
}
