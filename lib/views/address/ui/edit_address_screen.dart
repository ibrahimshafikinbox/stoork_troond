import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/address/controller/address_controller.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/text/build_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../config/app_local/app_local.dart';
import '../model/address_model.dart';

class EditAddressScreen extends StatelessWidget {
  const EditAddressScreen({super.key, required this.address});
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    var addressController = Provider.of<AddressController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: addressController.editAddressKey,
        child: ListView(
          children: [
            Center(child: BuildHeader(text: local.editAddress)),

            const SizedBox(height: 10),
            //* Type
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      address.type = "home";
                      addressController.update();
                    },
                    child: Text(local.home),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      address.type = "work";
                      addressController.update();
                    },
                    child: Text(local.work),
                  ),
                  PopupMenuItem(
                    child: Text(local.other),
                    onTap: () {
                      address.type = "other";
                      addressController.update();
                    },
                  ),
                ];
              },
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    local.type,
                    style: const TextStyle(
                      color: AppColor.c121212,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                subtitle: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColor.cDBDBDB),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(address.type),
                        const FaIcon(FontAwesomeIcons.chevronDown)
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                //* State
                Expanded(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        local.state,
                        style: const TextStyle(
                          color: AppColor.c121212,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    subtitle: BuildInput(
                      controller: TextEditingController(text: address.state),
                      validator: AppValidation.required(),
                      onChange: (value) {
                        address.state = value;
                      },
                    ),
                  ),
                ),

                //* City
                Expanded(
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        local.city,
                        style: const TextStyle(
                          color: AppColor.c121212,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    subtitle: BuildInput(
                      controller: TextEditingController(text: address.city),
                      validator: AppValidation.required(),
                      onChange: (value) {
                        address.city = value;
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

            //* Address
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  local.address,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              subtitle: BuildInput(
                controller: TextEditingController(text: address.mainAdress),
                validator: AppValidation.required(),
                onChange: (value) {
                  address.mainAdress = value;
                },
              ),
            ),

            const SizedBox(height: 5),

            //* phone
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  local.phoneNumber,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              subtitle: BuildInput(
                controller: TextEditingController(text: address.phone),
                validator: AppValidation.required(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChange: (value) {
                  address.phone = value;
                },
              ),
            ),

            const SizedBox(height: 20),
            //* add
            addressController.isLoading == address.id
                ? const LoadingWidget()
                : BuildTextBtn(
                    color: AppColor.main,
                    onTap: () {
                      addressController.updateAddress(
                        address: address,
                        context: context,
                      );
                    },
                    text: local.editAddress,
                  ),
          ],
        ),
      ),
    );
  }
}
