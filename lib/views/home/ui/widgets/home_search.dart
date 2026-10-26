// import 'package:bootstrap_icons/bootstrap_icons.dart';
// import 'package:flutter/material.dart';
// import 'package:troond/config/app_color/app_color.dart';
// import 'package:troond/widget/input/build_input.dart';

// class HomeSearch extends StatelessWidget {
//   const HomeSearch({super.key , required this.appLocal});
//   final dynamic appLocal;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 20,
//         right: 20,
//       ),
//       child: SizedBox(
//         height: 60,
//         child: Card(
//           color: AppColor.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(7),
//             side: const BorderSide(color: AppColor.white),
//           ),
//           child: BuildInput(
//             hintText: appLocal.inputHint,
//             suffixIcon: Container(
//               width: 60,
//               height: 70,
//               color: AppColor.mainColor,
//               child: IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   BootstrapIcons.search,
//                   color: AppColor.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
