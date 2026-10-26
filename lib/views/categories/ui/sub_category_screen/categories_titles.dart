import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

import '../../../home/model/category_model.dart';
import '../../../main_screen/controller/main_controller.dart';

class CategoriesTitlesWidget extends StatelessWidget {
  const CategoriesTitlesWidget({
    super.key,
    required this.result,
    required this.mainController,
  });
  final List<CategoryModel> result;
  final MainController mainController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: double.infinity,
        color: AppColor.cFFF0D5,
        child: ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                mainController.changeCatgory(
                  index,
                  result[index].children,
                );
              },
              child: Material(
                color: index == mainController.activeCategories
                    ? AppColor.white
                    : AppColor.cFFF0D5,
                child: Row(
                  children: [
                    index == mainController.activeCategories
                        ? Container(
                            width: 4,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: AppColor.main,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          result[index].name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColor.c121212,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
