import 'package:flutter/material.dart';
// import 'package:troond/config/app_local/app_local.dart';
// import 'orders/supplier_orders_tab.dart';
import 'product/supplier_product_tab.dart';

class SupplierProductScreen extends StatefulWidget {
  const SupplierProductScreen({super.key});

  @override
  State<SupplierProductScreen> createState() => _SupplierProductScreenState();
}

class _SupplierProductScreenState extends State<SupplierProductScreen> {
  // List<Widget> screens = const [
  //   SupplierProductsTab(),
  //   SupplierOrdersTab(),
  //   SupplierOrdersTab(),
  // ];
  // int index = 0;

  @override
  Widget build(BuildContext context) {
    // var local = MyLocalizations.getLocal(context);
    return const Scaffold(
      //* Tab Bar removed — show products directly
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: Icon(BootstrapIcons.box_seam),
      //       ),
      //       label: local.product,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: Icon(BootstrapIcons.truck),
      //       ),
      //       label: local.orders,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.all(8.0),
      //         child: Icon(BootstrapIcons.box_arrow_up_right),
      //       ),
      //       label: local.home,
      //     ),
      //   ],
      //   currentIndex: index,
      //   onTap: (value) {
      //     setState(() {
      //       index = value;
      //     });
      //   },
      // ),
      body: SupplierProductsTab(),
    );
  }
}
