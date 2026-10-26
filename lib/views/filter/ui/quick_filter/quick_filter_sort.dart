import 'package:flutter/material.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';

class QuickFilterSort extends StatelessWidget {
  const QuickFilterSort({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Material(
      color: AppColor.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Column(
        children: [
          //* header
          Material(
            color: AppColor.cF1F1F1,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 24,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    local.sortingBy,
                    style: const TextStyle(
                      color: AppColor.c3D3D3D,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: AppColor.c3D3D3D,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //* body
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 8,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SortingItem(text: local.popularity),
                    SortingItem(text: local.highToLow),
                    SortingItem(text: local.lowToHigh),
                    SortingItem(text: local.newArrivais),
                    SortingItem(text: local.bestRated),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SortingItem extends StatelessWidget {
  const SortingItem({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColor.c1E1E1E,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        Checkbox(
          checkColor: Colors.white,
          value: false,
          shape: const CircleBorder(),
          onChanged: (bool? value) {},
        )
      ],
    );
  }
}
