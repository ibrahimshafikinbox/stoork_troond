import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/product/model/product_preview.dart';

class EssentialDetailsWidget extends StatelessWidget {
  const EssentialDetailsWidget({
    super.key,
    required this.overview,
  });
  final List<Overveiw> overview;

  @override
  Widget build(BuildContext context) {
    if (overview.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: overview.map((overviewItem) {
        String cleanDesc = _cleanHtmlText(overviewItem.description);
        bool hasDesc = cleanDesc.isNotEmpty;
        bool hasItems = overviewItem.items.isNotEmpty;

        if (!hasDesc && !hasItems) return const SizedBox.shrink();

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasDesc) ...[
                Text(
                  cleanDesc,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (hasItems) ...[
                Column(
                  children: overviewItem.items.map((item) {
                    String itemDesc = "";
                    if (item is Map) {
                      itemDesc = item["description"] ?? item["name"] ?? "";
                    } else {
                      itemDesc = item.toString();
                    }
                    itemDesc = _cleanHtmlText(itemDesc);
                    if (itemDesc.isEmpty) return const SizedBox.shrink();

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 7),
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                              color: AppColor.main,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              itemDesc,
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 13.5,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    );
  }

  static String _cleanHtmlText(String raw) {
    if (raw.isEmpty) return "";
    String text = raw
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</li>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<li>', caseSensitive: false), '• ')
        .replaceAll(RegExp(r'</tr>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</td>', caseSensitive: false), '  ');
    text = text.replaceAll(RegExp(r'<[^>]*>'), '');
    text = text
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&#39;', "'");
    return text.replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
  }
}
