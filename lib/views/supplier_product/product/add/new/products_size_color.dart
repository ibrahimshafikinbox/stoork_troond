import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:troond/config/app_const/app_method.dart';
import 'package:troond/views/supplier_product/product/widget/product_text.dart';
import 'package:troond/views/supplier_product/services/supplier_product_services.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';

import '../../../../../config/app_local/app_local.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../widget/btn/text_btn.dart';
import '../../../controller/supplier_product_controller.dart';

class ProductSizeColor extends StatefulWidget {
  const ProductSizeColor({Key? key, required this.controller})
      : super(key: key);
  final SupplierProductController controller;

  @override
  State<ProductSizeColor> createState() => _ProductSizeColorState();
}

class _ProductSizeColorState extends State<ProductSizeColor> {
  Color pickerColor = const Color(0xff443a49);
  String colorToHex(Color color) {
    String hexColor = "#${color.value.toRadixString(16).substring(2)}";
    return hexColor;
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return FutureBuilder<List>(
      future: SupplierProductServices().getFullDetails(
        widget.controller.productId,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoadingWidget();
        } else {
          var result = snapshot.data!;
          return Column(
            children: [
              BorderText(
                height: 500,
                text: local.sizeColor,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: result.length,
                          itemBuilder: (context, index) {
                            var item = result[index];
                            List entries = item["items"];
                            return BorderText(
                              height: 150,
                              text: item["size"],
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GridView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: entries.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2.5,
                                        ),
                                        itemBuilder: (context, index) {
                                          var singleColor = entries[index];
                                          return Card(
                                            color: AppColor.cF6F6F6,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                        color: AppMethod()
                                                            .hexToColor(
                                                                singleColor[
                                                                    "color"]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          3,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                        color: AppColor.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          singleColor["count"]
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: AppColor
                                                                .c121212,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      widget.controller
                                                          .deleteColor(
                                                        singleColor["id"],
                                                      );
                                                    },
                                                    child: const SvgWidget(
                                                      svgName: "trash_red.svg",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Dialog(
                                                  child: SizedBox(
                                                    height: 230,
                                                    width: 300,
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          title: Text(
                                                            local.addNewColor,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: AppColor
                                                                  .c121212,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          trailing: IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                              Icons.clear,
                                                              color: AppColor
                                                                  .c121212,
                                                            ),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          title: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              bottom: 10,
                                                            ),
                                                            child: Text(
                                                              local.count,
                                                              style:
                                                                  const TextStyle(
                                                                color: AppColor
                                                                    .c3D3D3D,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ),
                                                          subtitle: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    BuildInput(
                                                                  controller: widget
                                                                      .controller
                                                                      .count,
                                                                  inputFormatters: [
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly,
                                                                  ],
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            local.pickColor),
                                                                        content:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              ColorPicker(
                                                                            pickerColor:
                                                                                pickerColor,
                                                                            onColorChanged:
                                                                                (value) {
                                                                              setState(() => pickerColor = value);
                                                                            },
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 46,
                                                                  width: 46,
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          5),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        pickerColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 10),
                                                        BuildTextBtn(
                                                          color: AppColor.main,
                                                          onTap: () {
                                                            widget.controller
                                                                .addColor(
                                                              size:
                                                                  item["size"],
                                                              color: colorToHex(
                                                                  pickerColor),
                                                              context: context,
                                                            );
                                                          },
                                                          text: local.add,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: DottedBorder(
                                            color: AppColor.main,
                                            dashPattern: const [5],
                                            strokeWidth: 1,
                                            radius: const Radius.circular(10),
                                            child: const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Icon(
                                                Icons.add,
                                                color: AppColor.main,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
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
                                      child: SizedBox(
                                        height: 320,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                local.addNewSize,
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
                                                  local.sizeName,
                                                  style: const TextStyle(
                                                    color: AppColor.c3D3D3D,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              subtitle: BuildInput(
                                                controller:
                                                    widget.controller.size,
                                              ),
                                            ),
                                            ListTile(
                                              title: Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 5,
                                                ),
                                                child: Text(
                                                  local.count,
                                                  style: const TextStyle(
                                                    color: AppColor.c3D3D3D,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Expanded(
                                                    child: BuildInput(
                                                      controller: widget
                                                          .controller.count,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                      ],
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              local.pickColor,
                                                            ),
                                                            content:
                                                                SingleChildScrollView(
                                                              child:
                                                                  ColorPicker(
                                                                pickerColor:
                                                                    pickerColor,
                                                                onColorChanged:
                                                                    (value) {
                                                                  setState(() =>
                                                                      pickerColor =
                                                                          value);
                                                                },
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 46,
                                                      width: 46,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        color: pickerColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            BuildTextBtn(
                                              color: AppColor.main,
                                              onTap: () {
                                                widget.controller.addSize(
                                                  color:
                                                      colorToHex(pickerColor),
                                                  context: context,
                                                );
                                              },
                                              text: local.add,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Center(
                                child: Text(
                                  "+ ${local.addNewSize}",
                                  style: const TextStyle(
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
              ),
              //* next
              BuildTextBtn(
                color: AppColor.main,
                onTap: () {
                  widget.controller.changeIndex2(2);
                },
                text: local.next,
              ),
            ],
          );
        }
      },
    );
  }
}
