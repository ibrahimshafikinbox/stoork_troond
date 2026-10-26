import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/fav/ui/fav_btn.dart';
import 'package:troond/views/my_list/model/my_list_model.dart';
import 'package:troond/widget/rate/rate_card.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/routes/app_routes.dart';
import '../../controller/my_list_controller.dart';
import '../actions/my_list_action.dart';
import '../actions/my_list_item_action.dart';

class MyListTab extends StatelessWidget {
  const MyListTab({
    super.key,
    required this.myListModel,
    required this.myListController,
  });
  final MyListModel myListModel;
  final MyListController myListController;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Column(
      children: [
        //* my list header
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "${myListModel.items.length} ${local.items}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: AppColor.main),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          myListModel.name,
                          style: const TextStyle(
                            color: AppColor.main,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColor.white,
                  builder: (context) {
                    return MyListAction(
                      myListController: myListController,
                      myListModel: myListModel,
                    );
                  },
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColor.main),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.more_horiz,
                    color: AppColor.main,
                  ),
                ),
              ),
            ),
          ],
        ),

        //* my list itemsF
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: myListModel.items.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
              ),
              itemBuilder: (context, index) {
                var product = myListModel.items[index].product;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.productPreviewScreen,
                      arguments: product.id,
                    );
                  },
                  child: Card(
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
                                isFav: false,
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

                        //* btn
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 5, left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //*  View product
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

                              //* my list item action
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor: AppColor.white,
                                        builder: (context) {
                                          return MyListItemAction(
                                            myListController: myListController,
                                            itemId: myListModel.id,
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
          ),
        ),
      ],
    );
  }
}
