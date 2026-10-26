// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:troond/config/app_color/app_color.dart';
// import 'package:troond/config/app_local/app_local.dart';
// import 'package:troond/views/fav/controller/fav_controller.dart';

// class FavActionsWidget extends StatelessWidget {
//   const FavActionsWidget({
//     super.key,
//     required this.favController,
//     required this.productId,
//   });
//   final FavController favController;
//   final int productId;

//   @override
//   Widget build(BuildContext context) {
//     var local = MyLocalizations.getLocal(context);
//     return SizedBox(
//       height: 270,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(
//                   Icons.clear,
//                   color: AppColor.color121212,
//                 ),
//               ),
//             ),

//             //* Add to another list
//             ListTile(
//               onTap: () {},
//               title: Text(
//                 local.addToAnotherList,
//                 style: const TextStyle(
//                   color: AppColor.color3D3D3D,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16,
//                 ),
//               ),
//               minLeadingWidth: 0,
//               leading: const Icon(
//                 Icons.arrow_forward,
//                 color: AppColor.c717171,
//               ),
//             ),

//             const Divider(),

//             //* View similar items
//             // const ListTile(
//             //   title: Text(
//             //     "View similar items",
//             //     style: TextStyle(
//             //       color: AppColor.color3D3D3D,
//             //       fontWeight: FontWeight.w500,
//             //       fontSize: 16,
//             //     ),
//             //   ),
//             //   minLeadingWidth: 0,
//             //   leading: Icon(
//             //     Icons.arrow_forward,
//             //     color: AppColor.c717171,
//             //   ),
//             // ),

//             const Divider(),

//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: TextButton.icon(
//                   onPressed: () {
//                     favController.delete(
//                       productId: productId,
//                       context: context,
//                     );
//                   },
//                   icon: const Icon(
//                     BootstrapIcons.trash3,
//                     color: AppColor.cFA4040,
//                   ),
//                   label: Text(
//                     local.delete,
//                     style: const TextStyle(
//                       color: AppColor.cFA4040,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
