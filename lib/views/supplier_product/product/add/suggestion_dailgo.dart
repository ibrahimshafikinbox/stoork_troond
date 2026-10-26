import 'package:flutter/material.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/valid/app_validation.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../../widget/input/build_input.dart';
import '../../controller/supplier_product_controller.dart';

class BuildSuggestion {
  addNewCategory({
    required BuildContext context,
    required SupplierProductController controller,
  }) {
    var local = MyLocalizations.getLocal(context);
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Form(
            key: controller.addNewCategoryKey,
            child: SizedBox(
              height: 350,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        local.addNewSuggestion,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.c121212,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: AppColor.c121212,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          local.categoryName,
                          style: const TextStyle(
                            color: AppColor.c3D3D3D,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: BuildInput(
                        controller: controller.categoryName,
                        validator: AppValidation.required(),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          local.yourNote,
                          style: const TextStyle(
                            color: AppColor.c3D3D3D,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: BuildInput(
                        controller: controller.categoryNote,
                        maxLines: 5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BuildTextBtn(
                      color: AppColor.main,
                      onTap: () {
                        controller.addNewCategory(context);
                      },
                      text: local.add,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  addNewSubcategory({
    required BuildContext context,
    required SupplierProductController controller,
  }) {
    var local = MyLocalizations.getLocal(context);
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Form(
            key: controller.addNewCategoryKey2,
            child: SizedBox(
              height: 350,
              width: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        local.addNewSuggestion,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColor.c121212,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: AppColor.c121212,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          local.subCategoryName,
                          style: const TextStyle(
                            color: AppColor.c3D3D3D,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: BuildInput(
                        controller: controller.categoryName2,
                        validator: AppValidation.required(),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 5,
                        ),
                        child: Text(
                          local.yourNote,
                          style: const TextStyle(
                            color: AppColor.c3D3D3D,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      subtitle: BuildInput(
                        controller: controller.categoryNote2,
                        maxLines: 5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BuildTextBtn(
                      color: AppColor.main,
                      onTap: () {
                        controller.addNewSubcategory(context);
                      },
                      text: local.add,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
