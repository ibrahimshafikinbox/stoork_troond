import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_const/app_method.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/views/product/model/product_preview.dart';

import '../../../../../config/app_local/app_local.dart';

class LayoutWidget extends StatelessWidget {
  const LayoutWidget({
    super.key,
    required this.productPreview,
  });
  final ProductPreview productPreview;

  @override
  Widget build(BuildContext context) {
    CartController cartController = Provider.of<CartController>(context);
    List<Detail> newDetails = cartController.newDetails;
    List<Detail> oldDetails = productPreview.details;

    Set colors = {};
    Set sizes = {};
    for (var element in oldDetails) {
      colors.add(element.color);
      sizes.add(element.size);
    }
    List sizesList = sizes.toList();
    List colorsList = colors.toList();
    var local = MyLocalizations.getLocal(context);
    return oldDetails.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //* sizes
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      local.size,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.c121212,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: sizesList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 8,
                      ),
                      itemBuilder: (context, index) {
                        String item = sizesList[index];
                        return InkWell(
                          onTap: () {
                            cartController.chooseSize(
                              details: oldDetails,
                              size: item,
                              color: "",
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: newDetails.any(
                                            (element) => element.size == item)
                                        ? AppColor.main
                                        : AppColor.cB8B8B8),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColor.c121212,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                //* colors
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      local.color,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.c121212,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: colorsList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                      ),
                      itemBuilder: (context, index) {
                        String item = colorsList[index];
                        return InkWell(
                          onTap: () {
                            cartController.chooseSize(
                              details: oldDetails,
                              size: "",
                              color: item,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              backgroundColor: AppMethod().hexToColor(item),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}


// newDetails.any((element) => element.color == item)
//                             ? InkWell(
//                                 onTap: () {
//                                   cartController.chooseSize(
//                                     details: oldDetails,
//                                     size: "",
//                                     color: item,
//                                   );
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: CircleAvatar(
//                                     backgroundColor:
//                                         AppMethod().hexToColor(item),
//                                   ),
//                                 ),
//                               )
//                             : const SizedBox();