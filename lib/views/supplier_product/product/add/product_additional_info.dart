import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../../widget/input/build_input.dart';
import '../../../product/model/product_preview.dart';
import '../../controller/supplier_product_controller.dart';
import '../widget/product_text.dart';

class ProductAdditionalInfo extends StatelessWidget {
  const ProductAdditionalInfo({
    super.key,
    required this.controller,
    required this.product,
  });
  final ProductPreview product;
  final SupplierProductController controller;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Column(
      children: [
        //* overview
        BorderText(
          height: (300 * product.overveiw.length).toDouble() + 110,
          text: local.overview,
          child: Wrap(
            children: [
              ListView.builder(
                itemCount: product.overveiw.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = product.overveiw[index];
                  return BorderText(
                    height: 280,
                    text: local.header,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  local.header,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              subtitle: BuildInput(
                                controller: TextEditingController(
                                  text: item.header,
                                ),
                                readOnly: true,
                              ),
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
                              subtitle: BuildInput(
                                hintText: local.productDescription,
                                maxLines: 5,
                                controller: TextEditingController(
                                  text: item.description,
                                ),
                                readOnly: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              //* + Add New section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: DottedBorder(
                  color: AppColor.main,
                  dashPattern: const [5],
                  strokeWidth: 1,
                  radius: const Radius.circular(15),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Form(
                              key: controller.overviewKey,
                              child: SizedBox(
                                height: 380,
                                width: 300,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          local.addNewOverview,
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
                                            local.header,
                                            style: const TextStyle(
                                              color: AppColor.c3D3D3D,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        subtitle: BuildInput(
                                          controller: controller.headerOverview,
                                          validator: AppValidation.required(),
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 5,
                                          ),
                                          child: Text(
                                            local.productDescription,
                                            style: const TextStyle(
                                              color: AppColor.c3D3D3D,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        subtitle: BuildInput(
                                          maxLines: 8,
                                          controller: controller.descOverview,
                                          validator: AppValidation.required(),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      controller.loading == 6
                                          ? const LoadingWidget()
                                          : BuildTextBtn(
                                              color: AppColor.main,
                                              onTap: () {
                                                controller.addNewOverview(
                                                  context,
                                                );
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
                    },
                    child: const Center(
                      child: Text(
                        "+ Add New section",
                        style: TextStyle(
                          color: AppColor.main,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //* Specifications
        BorderText(
          height: (150 * product.options.length).toDouble() + 110,
          text: "Specifications",
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: product.options.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = product.options[index];
                    return BorderText(
                      height: 100,
                      text: "Specification (${index + 1})",
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Name",
                                    style: TextStyle(
                                      color: AppColor.c3D3D3D,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                subtitle: BuildInput(
                                  controller: TextEditingController(
                                    text: item.name,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Value",
                                    style: TextStyle(
                                      color: AppColor.c3D3D3D,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                subtitle: BuildInput(
                                  controller: TextEditingController(
                                    text: item.value,
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

                const SizedBox(height: 20),

                //* + Add New section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: DottedBorder(
                    color: AppColor.main,
                    dashPattern: const [5],
                    strokeWidth: 1,
                    radius: const Radius.circular(15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Form(
                                key: controller.opitionKey,
                                child: SizedBox(
                                  height: 350,
                                  width: 350,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: const Text(
                                            "Add new Specification",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
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
                                          title: const Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 5,
                                            ),
                                            child: Text(
                                              "Name",
                                              style: TextStyle(
                                                color: AppColor.c3D3D3D,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          subtitle: BuildInput(
                                            controller: controller.nameOption,
                                            validator: AppValidation.required(),
                                          ),
                                        ),
                                        ListTile(
                                          title: const Padding(
                                            padding: EdgeInsets.only(
                                              bottom: 5,
                                            ),
                                            child: Text(
                                              "Value",
                                              style: TextStyle(
                                                color: AppColor.c3D3D3D,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          subtitle: BuildInput(
                                            controller: controller.valueOption,
                                            validator: AppValidation.required(),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        controller.loading == 7
                                            ? const LoadingWidget()
                                            : BuildTextBtn(
                                                color: AppColor.main,
                                                onTap: () {
                                                  controller.addNewOption(
                                                    context: context,
                                                    order:
                                                        product.options.length +
                                                            1,
                                                  );
                                                },
                                                text: "Add",
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Center(
                        child: Text(
                          "+ Add New section",
                          style: TextStyle(
                            color: AppColor.main,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
