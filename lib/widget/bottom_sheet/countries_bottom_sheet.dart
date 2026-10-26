// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:troond/config/app_assets/app_assets.dart';
// import 'package:troond/config/app_color/app_color.dart';
// import 'package:troond/widget/btn/text_btn.dart';

// class Countries {
//   final String name;
//   final String images;

//   Countries({required this.name, required this.images});
// }

// List<Countries> countries = [
//   Countries(name: 'Egypt', images: 'en'),
//   Countries(name: 'Egypt', images: 'es'),
//   Countries(name: 'Egypt', images: 'fr'),
//   Countries(name: 'Egypt', images: 'de'),
//   Countries(name: 'Egypt', images: 'it'),
//   Countries(name: 'Egypt', images: 'ja'),
//   Countries(name: 'Egypt', images: 'zh'),
// ];

// class ChooseCountriesDailgo extends StatefulWidget {
//   const ChooseCountriesDailgo({super.key});

//   @override
//   State<ChooseCountriesDailgo> createState() => _ChooseCountriesDailgoState();
// }

// class _ChooseCountriesDailgoState extends State<ChooseCountriesDailgo> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 300.0,
//       child: Column(
//         children: <Widget>[
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               "Select Country",
//               style: TextStyle(
//                 color: AppColor.c1E1E1E,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//           Expanded(
//             child: CupertinoPicker(
//               itemExtent: 40.0,
//               diameterRatio: 10,
//               onSelectedItemChanged: (int index) {},
//               children: List.generate(
//                 countries.length,
//                 (int index) => ListTile(
//                   title: Text(
//                     countries[index].name,
//                     style: const TextStyle(fontSize: 20.0),
//                   ),
//                   leading: const Image(
//                     image: AssetImage(
//                       "${AppAssets.dummyImages}flag.png",
//                     ),
//                   ),
//                   trailing: Checkbox(
//                     value: index == 0,
//                     shape: const CircleBorder(),
//                     activeColor: AppColor.mainColor,
//                     onChanged: (value) {},
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 60),
//               child: BuildTextBtn(
//                 color: AppColor.mainColor,
//                 onTap: () {},
//                 text: 'Confirm',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
