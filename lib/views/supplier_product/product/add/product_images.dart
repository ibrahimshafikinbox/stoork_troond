import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/supplier_product/controller/supplier_product_controller.dart';
import 'package:troond/views/supplier_product/product/widget/product_text.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../widget/btn/text_btn.dart';

class AddProductImages extends StatelessWidget {
  const AddProductImages({
    super.key,
    required this.product,
    required this.controller,
  });
  final ProductPreview product;
  final SupplierProductController controller;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Column(
      children: [
        BorderText(
          height: 500,
          text: local.image,
          child: Padding(
            padding: const EdgeInsets.only(top: 13, right: 5, left: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  product.images.isEmpty
                      ? const SizedBox()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: product.images.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                          ),
                          itemBuilder: (context, index) {
                            var item = product.images[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: AppColor.cDADCE3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Center(
                                      child: SizedBox(
                                        height: 100,
                                        child: Stack(
                                          children: [
                                            Image(
                                              width: 300,
                                              alignment: Alignment.center,
                                              image: CachedNetworkImageProvider(
                                                item.path,
                                              ),
                                            ),
                                            const Align(
                                              alignment: Alignment.topLeft,
                                              child: SvgWidget(
                                                svgName: "edit.svg",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(color: AppColor.cDADCE3),
                                  controller.loading == item.id
                                      ? const LoadingWidget()
                                      : Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                controller.setImage(
                                                    imageId: item.id);
                                              },
                                              icon: Icon(
                                                Icons.check_circle,
                                                color: item.isMain == 1
                                                    ? AppColor.cFFAF91
                                                    : AppColor.main,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                local.setAsDefault,
                                                style: const TextStyle(
                                                  color: AppColor.c3D3D3D,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.deleteImage(item.id);
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: SvgWidget(
                                                  svgName: "trash_red.svg",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            );
                          },
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: controller.loading == 1
                        ? const LoadingWidget()
                        : InkWell(
                            onTap: () {
                              controller.addImage(
                                (product.images.length + 1).toString(),
                              );
                            },
                            child: DottedBorder(
                              color: AppColor.cDADCE3,
                              dashPattern: const [5],
                              strokeWidth: 1,
                              radius: const Radius.circular(10),
                              child:  Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      local.upload,
                                      style: const TextStyle(
                                        color: AppColor.main,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                     local.orDropFilesToUpload,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: AppColor.c717171,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //* next
        BuildTextBtn(
          color: AppColor.main,
          onTap: () {},
          text: "Next",
        ),
      ],
    );
  }
}
