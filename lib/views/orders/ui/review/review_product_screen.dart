import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/l10n/app_localizations.dart';
import '../../../../config/app_local/app_local.dart';
import '../../model/order_model.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({Key? key, required this.orderItem})
      : super(key: key);
  final OrderModelItem orderItem;

  @override
  State<ReviewProductScreen> createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  TextEditingController review = TextEditingController();
  int rate = 0;
  final rateKey = GlobalKey<FormState>();
  String error = "";
  bool loading = false;

  rateProduct(AppLocalizations local) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 200,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 80,
                    width: 80,
                    child: SvgWidget(svgName: "done.svg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      local.thankYouForSharing,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColor.c3D3D3D,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(local.productReview),
        centerTitle: true,
      ),
      body: Form(
        key: rateKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  right: 16,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColor.cDADCE3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.productPreviewScreen,
                              arguments: widget.orderItem.product.id,
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      widget.orderItem.product.images[0].path,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.orderItem.product.name,
                                      style: const TextStyle(
                                        color: AppColor.c121212,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      widget.orderItem.product.description,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: AppColor.c717171,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Divider(color: AppColor.cDADCE3),
                        const SizedBox(height: 5),
                        Text(
                          local.addReview,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColor.c3D3D3D,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          local.yourOverAllRating,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColor.cC3C3C3,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            for (int i = 1; i <= 5; i++)
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    rate = i;
                                  });
                                },
                                child: Icon(
                                  Icons.star_rounded,
                                  color: rate >= i
                                      ? AppColor.main
                                      : AppColor.cC3C3C3,
                                  size: 30,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Divider(color: AppColor.cDADCE3),
                        const SizedBox(height: 5),
                        Text(
                          local.setYourReview,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColor.c3D3D3D,
                          ),
                        ),
                        const SizedBox(height: 10),
                        BuildInput(
                          controller: review,
                          validator: AppValidation.required(),
                          maxLines: 6,
                          hintText: local.whatDidYouLikeOrDeslike,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          error,
                          style: const TextStyle(
                            color: AppColor.cD21318,
                          ),
                        ),
                        const SizedBox(height: 10),
                        loading
                            ? const LoadingWidget()
                            : BuildTextBtn(
                                padding: 0,
                                color: AppColor.main,
                                onTap: () {
                                  rateProduct(local);
                                },
                                text: local.giveUsFeedback,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
