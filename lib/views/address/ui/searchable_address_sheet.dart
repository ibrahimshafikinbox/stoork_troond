import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/theme/app_color.dart';

class SearchableAddressSelectorSheet extends StatefulWidget {
  const SearchableAddressSelectorSheet({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  final String title;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String> onSelected;

  @override
  State<SearchableAddressSelectorSheet> createState() =>
      _SearchableAddressSelectorSheetState();
}

class _SearchableAddressSelectorSheetState
    extends State<SearchableAddressSelectorSheet> {
  late TextEditingController searchController;
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems = widget.items;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filter(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredItems = widget.items;
      } else {
        filteredItems = widget.items
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsetsDirectional.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        start: 16,
        end: 16,
        top: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),

          // Header Title & Close
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColor.c121212,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColor.c717171),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Search Field
          TextField(
            controller: searchController,
            onChanged: _filter,
            decoration: InputDecoration(
              hintText: local.search,
              prefixIcon: const Icon(
                BootstrapIcons.search,
                size: 18,
                color: AppColor.c717171,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColor.main),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // List of Items
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Text(
                      "لا توجد نتائج متطابقة",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  )
                : ListView.separated(
                    itemCount: filteredItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      final isSelected = item == widget.selectedItem;
                      return ListTile(
                        onTap: () {
                          widget.onSelected(item);
                          Navigator.pop(context);
                        },
                        title: Text(
                          item,
                          style: TextStyle(
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color:
                                isSelected ? AppColor.main : AppColor.c121212,
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle,
                                color: AppColor.main)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
