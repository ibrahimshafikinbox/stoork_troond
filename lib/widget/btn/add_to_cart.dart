import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/widget/loading/loading_widget.dart';

import '../../config/app_local/app_local.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    super.key,
    required this.productId,
    required this.count,
  });
  final int productId;
  final int count;

  @override
  Widget build(BuildContext context) {
    // Cart functionality commented out by user request
    return const SizedBox.shrink();
    /*
    CartController cartController = Provider.of<CartController>(context);
    var local = MyLocalizations.getLocal(context);
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColor.main,
        fixedSize: const Size(200, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      onPressed: () {
        cartController.addToCart(
          id: productId,
          context: context,
          count: count,
        );
      },
      child: cartController.isAdding == productId
          ? const LoadingWidget()
          : Text(
              local.addToCart,
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
