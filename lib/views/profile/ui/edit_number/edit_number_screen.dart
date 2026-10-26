import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/profile/controller/profile_controller.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/app_local/app_local.dart';

class EditNumberScreen extends StatelessWidget {
  const EditNumberScreen({super.key, required this.userId});
  final int userId;

  @override
  Widget build(BuildContext context) {
    var profileController = Provider.of<ProfileController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: profileController.phoneKey,
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  local.setUpYourPrimaryNumber,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Text(
                    local.pleaseEnterPin,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColor.c717171,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            //* phone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    local.phoneNumber,
                    style: const TextStyle(
                      color: AppColor.c3D3D3D,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  BuildInput(
                    hintText: local.enterYourNumber,
                    inputType: TextInputType.phone,
                    controller: profileController.phone,
                    validator: AppValidation.phone(),
                    iconButton: CountryCodePicker(
                      onChanged: (value) {
                        profileController.cityKey = value.dialCode!;
                      },
                      initialSelection: 'TR',
                      showDropDownButton: true,
                      showFlag: false,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            //* button
            profileController.isUpdatePhone == true
                ? const LoadingWidget()
                : BuildTextBtn(
                    onTap: () {
                      profileController.updatePhone(
                        userId: userId,
                        context: context,
                      );
                    },
                    color: AppColor.main,
                    text: local.changeNumber,
                  ),
          ],
        ),
      ),
    );
  }
}
