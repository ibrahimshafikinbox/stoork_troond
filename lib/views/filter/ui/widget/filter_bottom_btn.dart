// import 'package:flutter/material.dart';
// import '../../../../config/app_local/app_local.dart';
// import '../../../../config/theme/app_color.dart';

// class FilterBtn extends StatelessWidget {
//   const FilterBtn({
//     super.key,
//     required this.text,
//     required this.onTap,
//   });
//   final String text;
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     var local = MyLocalizations.getLocal(context);
//     return Material(
//       color: AppColor.main,
//       child: SafeArea(
//         bottom: true,
//         child: TextButton(
//           style: TextButton.styleFrom(backgroundColor: AppColor.main),
//           onPressed: onTap,
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 local.filter,
//                 style: const TextStyle(
//                   color: AppColor.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
