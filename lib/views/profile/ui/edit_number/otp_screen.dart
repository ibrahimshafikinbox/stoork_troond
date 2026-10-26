// import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:troond/config/app_color/app_color.dart';
// import 'package:troond/config/app_routes/app_routes.dart';
// import 'package:troond/widget/screen_with_app_bar/screen_with_app_bar.dart';
// import 'package:troond/widget/btn/text_btn.dart';

// class OtpScreen extends StatelessWidget {
//   const OtpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenWithAppBar(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               width: 300,
//               child: Column(
//                 children: const [
//                   SizedBox(height: 30),
//                   Text(
//                     "Please verify your mobile number",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColor.color121212,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 24,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     "Please enter the PIN sent to your phone number (01019179162)",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColor.c717171,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: OTPTextField(
//                 length: 4,
//                 width: MediaQuery.of(context).size.width,
//                 fieldWidth: 40,
//                 spaceBetween: 10,
//                 otpFieldStyle: OtpFieldStyle(
//                   borderColor: AppColor.mainColor,
//                   // backgroundColor: AppColor.mainColor,
//                   disabledBorderColor: AppColor.mainColor,
//                   enabledBorderColor: AppColor.mainColor,
//                   focusBorderColor: AppColor.mainColor,
//                 ),
//                 textFieldAlignment: MainAxisAlignment.center,
//                 fieldStyle: FieldStyle.underline,
//                 keyboardType: TextInputType.phone,
//                 style: const TextStyle(),
//                 controller: OtpFieldController(),
//                 onChanged: (value) {},
//                 onCompleted: (pin) {},
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Divider(),

//             //* resend otp
//             const SizedBox(height: 40),

//             InkWell(
//               onTap: () {},
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Text(
//                     "Didn’t receive the PIN? ",
//                     style: TextStyle(
//                       color: AppColor.c717171,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     "Resend PIN",
//                     style: TextStyle(
//                       color: AppColor.color2B2B8D,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             //* confirm
//             const SizedBox(height: 40),
//             BuildTextBtn(
//               onTap: () {
//                 Navigator.of(context).pushNamed(AppRoutes.otpScreen);
//               },
//               color: AppColor.notValid,
//               text: "Change number",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
