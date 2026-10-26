// ignore_for_file: deprecated_member_use

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/services/product_services.dart';
import 'package:troond/views/supplier_product/controller/supplier_product_controller.dart';
import 'package:troond/views/supplier_product/product/add/product_additional_info.dart';
import 'package:troond/views/supplier_product/product/add/product_images.dart';
import 'package:troond/views/supplier_product/product/add/products_size_color.dart';
import 'package:troond/views/supplier_product/product/widget/new_add_products_steps.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../../../config/app_local/app_local.dart';
import '../../../../../config/theme/app_color.dart';
import 'product_general_info.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SupplierProductController controller =
        Provider.of<SupplierProductController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(local.addProduct),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            controller.clear(context);
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: controller.index == 3
            ? SizedBox(
                height: 55,
                child: BuildTextBtn(
                  color: AppColor.main,
                  text: local.next,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  size: 150,
                                  color: AppColor.c2AA952,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  local.itemAddedSuccessfully,
                                  style: const TextStyle(
                                    color: AppColor.c121212,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  local.youHaveAddTheItemSuccessfully,
                                  style: const TextStyle(
                                    color: AppColor.c191919,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            : const SizedBox(),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 50),
                  AddProductSteps(
                    supplierProductController: controller,
                    index: 0,
                    text: local.generalInfo,
                    icon: BootstrapIcons.file,
                    onTap: () {
                      controller.changeIndex2(0);
                    },
                  ),
                  AddProductSteps(
                    supplierProductController: controller,
                    index: 1,
                    text: local.sizeColor,
                    icon: BootstrapIcons.aspect_ratio,
                    onTap: () {
                      controller.changeIndex2(1);
                    },
                  ),
                  AddProductSteps(
                    supplierProductController: controller,
                    index: 2,
                    text: local.price,
                    icon: BootstrapIcons.currency_dollar,
                    onTap: () {
                      controller.changeIndex2(2);
                    },
                  ),
                  AddProductSteps(
                    supplierProductController: controller,
                    index: 3,
                    text: local.additionalInfo,
                    icon: BootstrapIcons.info_circle,
                    onTap: () {
                      controller.changeIndex2(3);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder<ProductPreview?>(
            future: PorductServices().getProduct(
              controller.productId,
            ),
            builder: (context, snapshot) {
              return AddProductWidgets(
                controller: controller,
                product: snapshot.data,
              );
            },
          )
        ],
      ),
    );
  }
}

class AddProductWidgets extends StatelessWidget {
  const AddProductWidgets({
    super.key,
    required this.controller,
    required this.product,
  });
  final SupplierProductController controller;
  final ProductPreview? product;

  @override
  Widget build(BuildContext context) {
    switch (controller.index) {
      case 0:
        return ProductGeneralInfo(controller: controller);
      case 1:
        return ProductSizeColor(controller: controller);
      case 2:
        return AddProductImages(product: product!, controller: controller);
      case 3:
        return ProductAdditionalInfo(controller: controller, product: product!);
    }
    return ProductGeneralInfo(controller: controller);
  }
}




// class AddProductWidgets extends StatelessWidget {
//   const AddProductWidgets({
//     super.key,
//     required this.controller,
//     required this.product,
//   });
//   final SupplierProductController controller;
//   final ProductPreview? product;

//   @override
//   Widget build(BuildContext context) {
//     switch (controller.index) {
//       case 0:
//         return controller.productId != 0
//             ? product == null
//                 ? const SizedBox()
//                 : ProductGeneralInfo2(controller: controller, product: product!)
//             : ProductGeneralInfo(controller: controller);
//       case 1:
//         return product == null
//             ? const SizedBox()
//             : AddProductImages(product: product!, controller: controller);
//       case 2:
//         return ProductSizeColor(controller: controller);
//       case 3:
//         return product == null
//             ? const SizedBox()
//             : ProductAdditionalInfo(controller: controller, product: product!);
//     }
//     return controller.productId != 0
//         ? product == null
//             ? const SizedBox()
//             : ProductGeneralInfo2(controller: controller, product: product!)
//         : ProductGeneralInfo(controller: controller);
//   }
// }
