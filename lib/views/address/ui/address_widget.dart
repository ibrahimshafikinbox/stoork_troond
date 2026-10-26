import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/address/helper/addrres_helper.dart';
import 'package:troond/widget/divider/dot_divider.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/loading/loading_widget.dart';

import '../../../config/app_local/app_local.dart';
import '../controller/address_controller.dart';
import '../model/address_model.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.address,
    required this.addressController,
  });
  final AddressModel address;
  final AddressController addressController;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Material(
        color: AppColor.white,
        shape: BeveledRectangleBorder(
          side: const BorderSide(color: AppColor.cDADCE3),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            //* header
            Material(
              color: AppColor.cF2F0F0,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              child: ListTile(
                title: Text(
                  address.type.toUpperCase(),
                  style: const TextStyle(
                    color: AppColor.c3D3D3D,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    wordSpacing: 0.7,
                  ),
                ),
                minLeadingWidth: 0,
                leading: Icon(
                  AddressHelper.getType(address.type),
                  size: 30,
                  color: AppColor.c3D3D3D,
                ),
                trailing: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.editAddressScreen,
                      arguments: address,
                    );
                  },
                  child: const Icon(
                    BootstrapIcons.pencil_square,
                    size: 20,
                    color: AppColor.c3D3D3D,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            //* detials
            ListTile(
              leading: const Icon(Icons.place_outlined),
              minLeadingWidth: 0,
              title: Text(
                address.mainAdress,
                style: const TextStyle(
                  color: AppColor.c64646D,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),

            //* divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: BuildDividerDot(),
            ),

            const SizedBox(height: 10),

            //* actions
            ListTile(
              title: Text(
                address.isDefault ? local.default2 : local.setAsDefault,
                style: const TextStyle(
                  color: AppColor.c3D3D3D,
                  fontWeight: FontWeight.w400,
                ),
              ),
              minLeadingWidth: 0,
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              leading: addressController.isLoading == address.id
                  ? const CircleAvatar(
                      backgroundColor: AppColor.white,
                      child: LoadingWidget(),
                    )
                  : IconButton(
                      onPressed: () {
                        addressController.markAsDefault(
                          isDefault: !address.isDefault,
                          addressId: address.id,
                        );
                      },
                      icon: const Icon(
                        Icons.check_circle,
                        color: AppColor.main,
                      ),
                    ),
              trailing: addressController.isLoading == address.id
                  ? const CircleAvatar(
                      backgroundColor: AppColor.white,
                      child: LoadingWidget(),
                    )
                  : InkWell(
                      onTap: () {
                        addressController.deleteAddress(
                          id: address.id,
                          context: context,
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SvgWidget(svgName: "trash_red.svg"),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
