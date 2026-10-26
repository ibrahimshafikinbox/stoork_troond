import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/app_const/shared_const.dart';
import '../../../config/routes/app_routes.dart';
import '../../../data/shared_pref/shared_pref.dart';
import '../../../widget/btn/text_btn.dart';
import '../../../widget/loading/loading_widget.dart';
import '../../address/controller/address_controller.dart';
import '../../address/model/address_model.dart';
import '../../address/services/address_services.dart';
import 'change_address_card.dart';

class ChangeAddressScreen extends StatelessWidget {
  const ChangeAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddressController addressController =
        Provider.of<AddressController>(context);
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.addAddress)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<AddressModel>>(
                    future: AddressServices().getAddress(),
                    builder: (context, snapshot) {
                      var cache =
                          SharedPref.getKey(key: SharedConsts.addresses);
                      if (cache == null) {
                        return const LoadingWidget();
                      } else {
                        var data = jsonDecode(cache);
                        List<AddressModel> address = [];
                        for (var element in data["data"]) {
                          address.add(AddressModel.fromJson(element));
                        }
                        var result =
                            snapshot.hasData ? snapshot.data! : address;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: result.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var address = result[index];
                            return ChangeAddressCard(
                              address: address,
                              addressController: addressController,
                            );
                          },
                        );
                      }
                    },
                  ),

                  //* add address
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: const BorderSide(color: AppColor.main),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.addAddressScreen,
                        );
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            local.addNewAddress,
                            style: const TextStyle(
                              color: AppColor.main,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          //* add address
          SafeArea(
            top: false,
            child: BuildTextBtn(
              color: AppColor.main,
              onTap: () {
                Navigator.pop(context);
              },
              text: local.confirm,
            ),
          ),
        ],
      ),
    );
  }
}
