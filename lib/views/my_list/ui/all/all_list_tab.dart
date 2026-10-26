import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/fav/services/fav_services.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/my_list/ui/actions/all_list_action.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/routes/app_routes.dart';
import '../../controller/my_list_controller.dart';

class AllListTab extends StatelessWidget {
  const AllListTab({super.key, required this.myListController});
  final MyListController myListController;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return FutureBuilder<List<ProductPreview>>(
      future: FavServices().getFavList(),
      builder: (context, snapshot) {
        var cache = SharedPref.getKey(key: SharedConsts.fav);
        if (cache == null) {
          return const LoadingWidget();
        } else {
          var result = jsonDecode(cache);
          List<ProductPreview> json = [];
          for (var element in result["data"]) {
            json.add(ProductPreview.fromJson(element["product"]));
          }
          var favList = snapshot.hasData ? snapshot.data! : json;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: favList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                var product = favList[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.productPreviewScreen,
                      arguments: product.id,
                    );
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColor.cDADCE3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Wrap(
                      children: [
                        //* image
                        Stack(
                          children: [
                            Image(
                              height: 135,
                              width: MediaQuery.of(context).size.width,
                              image: CachedNetworkImageProvider(product.images[0].path),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: BuildFavBtn(
                                productId: product.id,
                                isFav: true,
                              ),
                            ),
                          ],
                        ),

                        //* name
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    color: AppColor.c121212,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: AppColor.c121212,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                //* price
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${product.price} ${AppStrings.currecy}",
                                      style: const TextStyle(
                                        color: AppColor.c121212,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      height: 30,
                                      child: RateCard(product: product),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 5,
                            right: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //* View product
                              Expanded(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.productPreviewScreen,
                                      arguments: product.id,
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColor.main,
                                    ),
                                  ),
                                  child: Text(
                                    local.viewProduct,
                                    style: const TextStyle(
                                      color: AppColor.main,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),

                              //* Actions
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: AppColor.white,
                                        builder: (context) {
                                          return AllListAction(
                                            myListController: myListController,
                                            productId: product.id,
                                          );
                                        },
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: AppColor.main,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.more_horiz,
                                          color: AppColor.main,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
