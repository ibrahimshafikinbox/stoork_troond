// import 'package:flutter/material.dart';
// import 'package:troond/views/supplier_product/controller/supplier_product_controller.dart';
// import '../../../../config/theme/app_color.dart';

// class AddProductSteps extends StatelessWidget {
//   const AddProductSteps({
//     super.key,
//     required this.index,
//     required this.text,
//     required this.svgName,
//     required this.icon,
//     required this.onTap,
//     required this.supplierProductController,
//   });
//   final int index;
//   final String text;
//   final String svgName;
//   final IconData icon;
//   final Function() onTap;
//   final SupplierProductController supplierProductController;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Card(
//                   color: index <= supplierProductController.index
//                       ? AppColor.main
//                       : AppColor.cFFAF91,
//                   margin: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Icon(
//                       icon,
//                       size: 15,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     alignment: Alignment.center,
//                     color: index == 3
//                         ? AppColor.white
//                         : index <= supplierProductController.index
//                             ? AppColor.main
//                             : AppColor.cFFAF91,
//                     height: 2,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               width: 60,
//               height: 30,
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   color: AppColor.c414141,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
