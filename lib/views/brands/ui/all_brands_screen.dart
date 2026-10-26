import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/brands/services/brand_services.dart';
import 'package:troond/widget/loading/loading_widget.dart';

class AllBrandsScreen extends StatefulWidget {
  const AllBrandsScreen({super.key});

  @override
  State<AllBrandsScreen> createState() => _AllBrandsScreenState();
}

class _AllBrandsScreenState extends State<AllBrandsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<BrandModel> _allBrands = [];
  List<BrandModel> _filteredBrands = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBrands();
  }

  Future<void> _loadBrands() async {
    setState(() => _isLoading = true);
    try {
      final brands = await BrandServices().getAllBrnads();
      if (mounted) {
        setState(() {
          _allBrands = brands;
          _filteredBrands = brands;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredBrands = _allBrands;
      } else {
        final q = query.toLowerCase().trim();
        _filteredBrands = _allBrands.where((brand) {
          return brand.name.toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = MyLocalizations.getLocal(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0.5,
        leading: const BackButton(color: AppColor.c121212),
        title: Text(
          local.popularBrands,
          style: const TextStyle(
            color: AppColor.c121212,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: AppColor.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: local.search,
                  hintStyle: const TextStyle(
                    color: Color(0xFF868E96),
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF868E96),
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 18),
                          color: const Color(0xFF868E96),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),

          // Brands Grid
          Expanded(
            child: _isLoading
                ? const Center(child: LoadingWidget())
                : _filteredBrands.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.branding_watermark_outlined,
                              size: 64,
                              color: Color(0xFFCED4DA),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              local.localeName == 'ar'
                                  ? 'لا توجد ماركات مطابقة'
                                  : 'No matching brands found',
                              style: const TextStyle(
                                color: Color(0xFF868E96),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.82,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: _filteredBrands.length,
                        itemBuilder: (context, index) {
                          final brand = _filteredBrands[index];
                          final hasValidLogo = brand.logo.isNotEmpty &&
                              brand.logo.startsWith("http");

                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.brandScreen,
                                arguments: brand.id,
                              );
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: Container(
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
                                    color: Color(0x08000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Logo Container
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
                                              imageUrl: brand.logo,
                                              fit: BoxFit.contain,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child: SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    color: AppColor.main,
                                                  ),
                                                ),
                                              ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                child: Icon(
                                                  Icons
                                                      .branding_watermark_outlined,
                                                  color: Colors.grey,
                                                  size: 22,
                                                ),
                                              ),
                                            )
                                          : const Center(
                                              child: Icon(
                                                Icons
                                                    .branding_watermark_outlined,
                                                color: Colors.grey,
                                                size: 22,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Brand Name
                                  Text(
                                    brand.name,
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
