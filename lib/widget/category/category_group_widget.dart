import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/home/model/home_group_model.dart';
import '../../config/routes/app_routes.dart';
import '../../config/theme/app_color.dart';

class CategoryGroupWidget extends StatelessWidget {
  const CategoryGroupWidget({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.viewParentCategory,
          arguments: categoryModel.id,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
          height: 190,
          width: double.infinity,
          child: CachedNetworkImage(
              imageUrl: categoryModel.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(
                color: Colors.grey.shade100,
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColor.main,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade100,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}

class HomeGroupCardWidget extends StatelessWidget {
  const HomeGroupCardWidget({super.key, required this.groupModel});
  final HomeGroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    String lang = SharedPref.getLanguage();
    String imageUrl = groupModel.getImage(lang);

    return InkWell(
      onTap: () {
        if (groupModel.categoryId != null && groupModel.categoryId! > 0) {
          Navigator.of(context).pushNamed(
            AppRoutes.viewParentCategory,
            arguments: groupModel.categoryId,
          );
        } else if (groupModel.subCategoryId != null && groupModel.subCategoryId! > 0) {
          Navigator.of(context).pushNamed(
            AppRoutes.productsListScreen,
            arguments: {
              'categoryId': groupModel.subCategoryId,
              'title': groupModel.getName(lang),
            },
          );
        } else {
          Navigator.of(context).pushNamed(
            AppRoutes.viewParentCategory,
            arguments: groupModel.id,
          );
        }
      },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
          height: 190,
          width: double.infinity,
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(
                color: Colors.grey.shade100,
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColor.main,
                    ),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade100,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
