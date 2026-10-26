import 'package:flutter/material.dart';
import 'package:troond/views/product/model/product_preview.dart';

class AddToCart2 extends StatelessWidget {
  const AddToCart2({super.key, required this.productPreview});
  final ProductPreview productPreview;

  @override
  Widget build(BuildContext context) {
    // Cart button 2 functionality commented out by user request
    return const SizedBox.shrink();
    /*
    var local = MyLocalizations.getLocal(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColor.main,
        fixedSize: const Size(200, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: const Color(0x000000ff),
          builder: (context) {
            return AddToCartBody(productPreview: productPreview);
          },
        );
      },
      child: Text(
        local.addToCart2,
        style: const TextStyle(
          color: AppColor.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
    */
  }
}
