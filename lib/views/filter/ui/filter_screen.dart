import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/filter/controller/filter_controller.dart';
import 'package:troond/views/filter/model/filter_model.dart';
import 'package:troond/views/filter/services/filter_services.dart';
import 'package:troond/views/filter/ui/widget/filter_item.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../widget/btn/text_btn.dart';
import '../../../widget/input/build_input.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var filterController = Provider.of<FilterController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(local.filter),
        actions: [
          TextButton(
            onPressed: () {
              //*
            },
            child: Text(
              local.reset,
              style: const TextStyle(color: AppColor.c223263),
            ),
          ),
        ],
      ),
      body: FutureBuilder<FilterModel?>(
        future: FilterServices().getFilter(
          brand: filterController.getString(filterController.brandFilter),
          category: filterController.getString(filterController.categoryFilter),
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingWidget();
          } else {
            var result = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      FilterItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.categoryFilterScreen,
                            arguments: result,
                          );
                        },
                        title: local.category,
                      ),
                      FilterItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.filterBrandScreen,
                            arguments: result,
                          );
                        },
                        title: local.brand,
                      ),
                      FilterItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.filterColorScreen,
                            arguments: result,
                          );
                        },
                        title: local.color,
                      ),
                      // FilterItem(
                      //   onTap: () {},
                      //   title: "Size",
                      // ),
                      // FilterItem(
                      //   onTap: () {},
                      //   title: "Product Rating",
                      // ),
                      // FilterItem(
                      //   onTap: () {},
                      //   title: "Case Material",
                      // ),
                      // FilterItem(
                      //   onTap: () {},
                      //   title: "New Arrivals",
                      // ),
                      // FilterItem(
                      //   onTap: () {},
                      //   title: "Seller",
                      // ),
                      // ListTile(
                      //   title: const Text("Photo Reviews"),
                      //   minLeadingWidth: 0,
                      //   minVerticalPadding: 0,
                      //   trailing: const Padding(
                      //     padding: EdgeInsets.only(right: 30),
                      //     child: Icon(
                      //       Icons.photo_camera_back_outlined,
                      //       color: AppColor.mainColor,
                      //       size: 20,
                      //     ),
                      //   ),
                      //   contentPadding: EdgeInsets.zero,
                      //   leading: Checkbox(
                      //     value: false,
                      //     onChanged: (value) {},
                      //   ),
                      // ),
                      // ListTile(
                      //   title: const Text("Ready to ship"),
                      //   minLeadingWidth: 0,
                      //   trailing: const Padding(
                      //     padding: EdgeInsets.only(right: 30),
                      //     child: Icon(
                      //       // ignore: deprecated_member_use
                      //       FontAwesomeIcons.shippingFast,
                      //       color: AppColor.mainColor,
                      //       size: 20,
                      //     ),
                      //   ),
                      //   contentPadding: EdgeInsets.zero,
                      //   leading: Checkbox(
                      //     value: false,
                      //     onChanged: (value) {},
                      //   ),
                      // ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8),
                            child: Text(
                              local.price,
                              style: const TextStyle(
                                color: AppColor.c121212,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          local.min,
                                          style: const TextStyle(
                                            color: AppColor.c717171,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      const BuildInput(
                                        borderColor: AppColor.cB8B8B8,
                                        inputType: TextInputType.number,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 40,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  local.to,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: AppColor.c121212,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          local.max,
                                          style: const TextStyle(
                                            color: AppColor.c717171,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      const BuildInput(
                                        borderColor: AppColor.cB8B8B8,
                                        inputType: TextInputType.number,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: BuildTextBtn(
                    onTap: () {},
                    color: AppColor.main,
                    text: local.searchResults,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
