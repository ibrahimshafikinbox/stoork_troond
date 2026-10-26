import 'package:flutter/material.dart';
import 'package:troond/views/ads/helper/ads_helper.dart';
import 'package:troond/views/home/model/home_model.dart';
import 'package:troond/widget/images/cache_image.dart';
import '../../../config/theme/app_color.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key, required this.homeModel});
  final HomeModel homeModel;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  int initialPage = 0;
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          width: double.infinity,
          child: Stack(
            children: [
              //* sale card
              PageView.builder(
                controller: pageController,
                itemCount:
                    widget.homeModel.slider.items.length, // slider.length,
                onPageChanged: (value) {
                  setState(() {
                    initialPage = value;
                  });
                },
                itemBuilder: (context, index) {
                  var ad = widget.homeModel.slider.items[index];
                  return InkWell(
                    onTap: () {
                      AdsHelper().onTapAds(
                        productId: ad.productId,
                        context: context,
                        categoryId: ad.categoryId,
                        brandId: ad.brandId,
                      );
                    },
                    child: BuildCacheImage(
                      height: 140,
                      imageUrl: ad.mobileImage,
                      width: double.infinity,
                    ),
                  );
                },
              ),

              //* linear
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: 8,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget
                              .homeModel.slider.items.length, // slider.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: 20,
                                color: initialPage == index
                                    ? const Color(0xffFFF500)
                                    : AppColor.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
