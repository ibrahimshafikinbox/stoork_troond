// import 'package:flutter/material.dart';
// import 'package:troond/config/app_color/app_color.dart';
// import 'package:troond/config/app_local/app_local.dart';
// import 'package:troond/views/auth/ui/register/password_widget.dart';
// import 'package:troond/widget/input/build_input_header.dart';
// import 'package:troond/widget/btn/text_btn.dart';

// class CreateNewPasswordScreen extends StatelessWidget {
//   const CreateNewPasswordScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var local = MyLocalizations.getLocal(context);
//     return Scaffold(
//       appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 60),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //* header
//               Text(
//                 local.createNewPassword,
//                 style: const TextStyle(
//                   color: AppColor.c121212,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 24,
//                 ),
//               ),

//               const SizedBox(height: 50),

//               //* New Password
//               Column(
//                 children: [
//                   BuildInputHeader(
//                     header: local.newPassword,
//                     suffixIcon: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.visibility_off,
//                         color: AppColor.c717171,
//                       ),
//                     ),
//                   ),
//                   PasswordWidget(
//                     controller: TextEditingController(),
//                   ),
//                 ],
//               ),

//               //* Confirm Password
//               BuildInputHeader(
//                 header: local.confirmPassword,
//                 suffixIcon: IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.visibility_off,
//                     color: AppColor.c717171,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               //* SUBMIT
//               BuildTextBtn(
//                 color: AppColor.mainColor,
//                 onTap: () {},
//                 text: local.sbmit,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
