import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/views/ads/models/ads_model.dart';
import '../../../../config/theme/app_color.dart';

class SaleWidget extends StatefulWidget {
  const SaleWidget({super.key, required this.adsModels});
  final List<AdsModel> adsModels;

  @override
  State<SaleWidget> createState() => _SaleWidgetState();
}

class _SaleWidgetState extends State<SaleWidget> {
  int initialPage = 0;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.adsModels.isEmpty) return const SizedBox();

    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Stack(
        children: [
          //* sale card
          PageView.builder(
            controller: pageController,
            itemCount: widget.adsModels.length,
            onPageChanged: (value) {
              setState(() {
                initialPage = value;
              });
            },
            itemBuilder: (context, index) {
              String imgUrl = widget.adsModels[index].mobileImage?.toString() ?? "";
              bool isValidUrl = imgUrl.isNotEmpty && imgUrl.startsWith("http");

              return Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isValidUrl ? null : Colors.grey.shade200,
                  image: isValidUrl
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(imgUrl),
                          fit: BoxFit.contain,
                        )
                      : null,
                ),
                child: isValidUrl
                    ? null
                    : const Center(
                        child: Icon(Icons.image_not_supported, color: Colors.grey),
                      ),
              );
            },
          ),

          //* linear
          widget.adsModels.length <= 1
              ? const SizedBox()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: SizedBox(
                          height: 8,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: widget.adsModels.length,
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
    );
  }
}
