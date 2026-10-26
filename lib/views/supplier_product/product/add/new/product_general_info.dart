import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/supplier_product/product/add/suggestion_dailgo.dart';
import 'package:troond/views/supplier_product/product/widget/product_text.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../../config/app_local/app_local.dart';
import '../../../controller/supplier_product_controller.dart';
import '../../../services/supplier_product_services.dart';

class ProductGeneralInfo extends StatelessWidget {
  const ProductGeneralInfo({super.key, required this.controller});
  final SupplierProductController controller;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Form(
      child: Column(
        children: [
          BorderText(
            text: local.generalInfo,
            height: 520,
            child: ListView(
              children: [
                const SizedBox(height: 10),

                //* Name
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      local.productName,
                      style: const TextStyle(
                        color: AppColor.c3D3D3D,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  subtitle: BuildInput(
                    controller: controller.name,
                    hintText: local.enterProductName,
                    validator: AppValidation.required(),
                  ),
                ),

                //* Category
                FutureBuilder<List<CategoryModel>>(
                  future: CategoriesServices().getParentCategories(),
                  builder: (context, snapshot) {
                    var cache = SharedPref.getKey(
                      key: SharedConsts.parentCategories,
                    );
                    if (cache == null) {
                      return const LoadingWidget();
                    } else {
                      var json = jsonDecode(cache);
                      List<CategoryModel> categoriesList = [];
                      for (var element in json["data"]) {
                        categoriesList.add(CategoryModel.fromJson(element));
                      }
                      var result =
                          snapshot.hasData ? snapshot.data! : categoriesList;
                      List<CategoryModel> data = result
                          .where((element) => element.children.isNotEmpty)
                          .toList();
                      return Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  local.category,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              subtitle: PopupMenuButton(
                                child: SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: AppColor.cDBDBDB,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    title: Text(
                                      controller.categoryModel == null
                                          ? ""
                                          : controller.categoryModel!.name,
                                      textAlign: TextAlign.right,
                                    ),
                                    trailing: const FaIcon(
                                      FontAwesomeIcons.chevronDown,
                                      color: AppColor.c121212,
                                      size: 12,
                                    ),
                                  ),
                                ),
                                itemBuilder: (context) {
                                  return [
                                    for (int i = 0; i < data.length; i++)
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.chooseCategory(
                                            data[i],
                                          );
                                        },
                                        child: Text(data[i].name),
                                      ),
                                    PopupMenuItem(
                                      child: InkWell(
                                        onTap: () {
                                          BuildSuggestion().addNewCategory(
                                            context: context,
                                            controller: controller,
                                          );
                                        },
                                        child: Text(local.other),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  local.subCategory,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              subtitle: PopupMenuButton(
                                child: SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: AppColor.cDBDBDB,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    title: Text(
                                      controller.categorychild == null
                                          ? ""
                                          : controller.categorychild!.name,
                                      textAlign: TextAlign.right,
                                    ),
                                    trailing: const FaIcon(
                                      FontAwesomeIcons.chevronDown,
                                      color: AppColor.c121212,
                                      size: 12,
                                    ),
                                  ),
                                ),
                                itemBuilder: (context) {
                                  return controller.categoryModel == null
                                      ? []
                                      : [
                                          for (int i = 0;
                                              i <
                                                  controller.categoryModel!
                                                      .children.length;
                                              i++)
                                            PopupMenuItem(
                                              onTap: () {
                                                controller.chooseCategoryChild(
                                                  controller.categoryModel!
                                                      .children[i],
                                                );
                                              },
                                              child: Text(controller
                                                  .categoryModel!
                                                  .children[i]
                                                  .name),
                                            ),
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                BuildSuggestion()
                                                    .addNewSubcategory(
                                                  context: context,
                                                  controller: controller,
                                                );
                                              },
                                              child: Text(local.other),
                                            ),
                                          ),
                                        ];
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: FutureBuilder<List<BrandModel>>(
                        future: SupplierProductServices().getBrands(),
                        builder: (context, snapshot) {
                          var cache = SharedPref.getKey(
                            key: SharedConsts.brands,
                          );
                          if (cache == null) {
                            return const SizedBox();
                          } else {
                            var json = jsonDecode(cache);
                            List<BrandModel> brands = [];
                            for (var element in json["data"]) {
                              brands.add(BrandModel.fromJson(element));
                            }
                            var data =
                                snapshot.hasData ? snapshot.data! : brands;
                            return ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  local.brand,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              subtitle: PopupMenuButton(
                                child: SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: AppColor.cDBDBDB),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    title: Text(
                                      controller.brandModel == null
                                          ? ""
                                          : controller.brandModel!.name,
                                    ),
                                    trailing: const FaIcon(
                                      FontAwesomeIcons.chevronDown,
                                      color: AppColor.c121212,
                                      size: 12,
                                    ),
                                  ),
                                ),
                                itemBuilder: (context) {
                                  return [
                                    for (int i = 0; i < data.length; i++)
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.chooseBrand(
                                            data[i],
                                          );
                                        },
                                        child: Text(data[i].name),
                                      ),
                                  ];
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: Text(
                            local.material,
                            style: const TextStyle(
                              color: AppColor.c3D3D3D,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        subtitle: SizedBox(
                          height: 60,
                          child: BuildInput(
                            controller: controller.material,
                            validator: AppValidation.required(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      local.productDescription,
                      style: const TextStyle(
                        color: AppColor.c3D3D3D,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  subtitle: SizedBox(
                    child: BuildInput(
                      hintText: local.enterProductDescription,
                      maxLines: 10,
                      validator: AppValidation.required(),
                      controller: controller.description,
                    ),
                  ),
                ),
              ],
            ),
          ),
          controller.loading == 0
              ? const LoadingWidget()
              : BuildTextBtn(
                  color: AppColor.main,
                  onTap: () {
                    controller.changeIndex2(2);
                    // controller.addProduct(context);
                  },
                  text: local.next,
                ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
