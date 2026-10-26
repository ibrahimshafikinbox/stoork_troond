import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';

class ViewToggleBtn extends StatelessWidget {
  const ViewToggleBtn({
    super.key,
    required this.isGridView,
    required this.onChanged,
  });

  final bool isGridView;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              if (!isGridView) onChanged(true);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isGridView ? AppColor.main : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.grid_view_rounded,
                size: 18,
                color: isGridView ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: () {
              if (isGridView) onChanged(false);
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: !isGridView ? AppColor.main : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.view_list_rounded,
                size: 18,
                color: !isGridView ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
