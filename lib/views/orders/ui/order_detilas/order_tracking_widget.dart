import 'package:flutter/material.dart';
import 'package:troond/widget/images/svg_widget.dart';
import '../../../../config/theme/app_color.dart';

class OrderTrackingWidget extends StatelessWidget {
  const OrderTrackingWidget({
    super.key,
    required this.index,
    required this.text,
    required this.svgName,
  });
  final int index;
  final String text;
  final String svgName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgWidget(svgName: svgName),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_sharp,
                color: AppColor.c2AA952,
                size: 18,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: index == 3 ? AppColor.white : AppColor.c2AA952,
                  height: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            text,
            style: const TextStyle(
              color: AppColor.c717171,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
