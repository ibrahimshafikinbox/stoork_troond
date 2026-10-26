import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/search/services/search_services.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/app_local/app_local.dart';
import '../../product/ui/product_grid/product_grid.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({super.key, this.height = 40.0});
  final double height;

  @override
  Widget build(BuildContext context) {
    var appLocal = MyLocalizations.getLocal(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showSearch(context: context, delegate: DataSearch());
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE2E4E8),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                BootstrapIcons.search,
                color: AppColor.main,
                size: 17,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  appLocal.inputHint,
                  style: const TextStyle(
                    color: Color(0xFF8A8F9D),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    String q = query.trim();

    if (q.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                BootstrapIcons.search,
                size: 64,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 16),
              Text(
                local.inputHint,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder<List<ProductPreview>>(
      future: SearchServices().getSearch(q),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColor.main,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    BootstrapIcons.search,
                    size: 60,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "لم نتمكن من العثور على أي منتج يطابق \"$q\"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        var result = snapshot.data!;
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: BuildProductGrid(productList: result),
        );
      },
    );
  }
}
