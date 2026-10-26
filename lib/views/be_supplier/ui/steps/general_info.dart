// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';

// import '../../../../config/app_color/app_color.dart';
// import '../../../../config/app_valid/app_validation.dart';
// import '../../../../widget/input/build_input.dart';

// class GeneralInfo extends StatelessWidget {
//   const GeneralInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Be Supplier"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "General Info",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 24,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),

//             // Country/Region
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     "Country/Region",
//                     style: TextStyle(
//                       color: AppColor.c121212,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 subtitle: BuildInput(
//                   hintText: "Country/Region",
//                   validator: AppValidation.required(),
//                 ),
//               ),
//             ),

//             //* Email
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     "Email",
//                     style: TextStyle(
//                       color: AppColor.c121212,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 subtitle: BuildInput(
//                   hintText: "Email",
//                   validator: AppValidation.email(),
//                 ),
//               ),
//             ),

//             //* Full name
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     "Full name",
//                     style: TextStyle(
//                       color: AppColor.c121212,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 subtitle: BuildInput(
//                   hintText: "Full name",
//                   validator: AppValidation.required(),
//                 ),
//               ),
//             ),

//             //* Company name
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     "Company name",
//                     style: TextStyle(
//                       color: AppColor.c121212,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 subtitle: BuildInput(
//                   hintText: "Company name",
//                   validator: AppValidation.required(),
//                 ),
//               ),
//             ),

//             //* Phone number
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListTile(
//                 title: const Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Text(
//                     "Phone number",
//                     style: TextStyle(
//                       color: AppColor.c121212,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 subtitle: BuildInput(
//                   hintText: "Phone number",
//                   validator: AppValidation.phone(),
//                   iconButton: CountryCodePicker(
//                     onChanged: (value) {
//                       profileController.cityKey = value.code!;
//                     },
//                     initialSelection: 'TR',
//                     showDropDownButton: true,
//                     showFlag: false,
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
