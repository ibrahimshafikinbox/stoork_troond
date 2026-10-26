import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/address/controller/address_controller.dart';
import 'package:troond/views/address/services/address_services.dart';
import 'package:troond/views/address/ui/address_widget.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../config/app_local/app_local.dart';
import '../model/address_model.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = Provider.of<AddressController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<AddressModel>>(
              future: AddressServices().getAddress(),
              builder: (context, snapshot) {
                var cache = SharedPref.getKey(key: SharedConsts.addresses);
                if (cache == null) {
                  return const LoadingWidget();
                } else {
                  var data = jsonDecode(cache);
                  List<AddressModel> address = [];
                  for (var element in data["data"]) {
                    address.add(AddressModel.fromJson(element));
                  }

                  var result = snapshot.hasData ? snapshot.data! : address;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: result.length,
                    itemBuilder: (context, index) {
                      var address = result[index];
                      return AddressWidget(
                        address: address,
                        addressController: addressController,
                      );
                    },
                  );
                }
              },
            ),
          ),

          //* add address
          SafeArea(
            top: false,
            child: BuildTextBtn(
              color: AppColor.main,
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addAddressScreen);
              },
              text: local.addNewAddress,
            ),
          ),
        ],
      ),
    );
  }
}
