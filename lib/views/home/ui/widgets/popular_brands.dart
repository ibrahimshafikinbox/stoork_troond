import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/padding/app_padding.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/brands/services/brand_services.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../widget/btn/more_btn.dart';
import '../../model/home_model.dart';

class PopularBrandsWidget extends StatefulWidget {
  const PopularBrandsWidget({super.key, required this.homeModel});
  final HomeModel homeModel;

  @override
  State<PopularBrandsWidget> createState() => _PopularBrandsWidgetState();
}

class _PopularBrandsWidgetState extends State<PopularBrandsWidget> {
  final List<BrandModel> _brands = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.homeModel.brands.isNotEmpty) {
      _brands.addAll(widget.homeModel.brands);
      _isLoading = false;
    }
    _loadHomeBrands();
  }

  Future<void> _loadHomeBrands() async {
    List<BrandModel> fetched = await BrandServices().getHomeBrands();
    if (mounted && fetched.isNotEmpty) {
      setState(() {
        _brands.clear();
        _brands.addAll(fetched);
        _isLoading = false;
      });
    } else if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    if (_brands.isEmpty && !_isLoading) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.padding8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  local.popularBrands,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                MoreBtn(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.allBrandsScreen);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 130,
            child: _isLoading && _brands.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.main,
                      strokeWidth: 2,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _brands.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      var brandModel = _brands[index];
                      bool hasValidLogo = brandModel.logo.isNotEmpty &&
                          brandModel.logo.startsWith("http");

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRoutes.brandScreen,
                            arguments: brandModel.id,
                          );
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          width: 105,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFE8ECEF),
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Logo Box
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: hasValidLogo
                                      ? CachedNetworkImage(
                                          imageUrl: brandModel.logo,
                                          fit: BoxFit.contain,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColor.main,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                            child: Icon(
                                              Icons.branding_watermark_outlined,
                                              color: Colors.grey,
                                              size: 24,
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Icon(
                                            Icons.branding_watermark_outlined,
                                            color: Colors.grey,
                                            size: 24,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Brand Name
                              Text(
                                brandModel.name,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: AppColor.c121212,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
