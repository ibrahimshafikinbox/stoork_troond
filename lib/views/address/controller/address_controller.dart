// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/address/model/cities_model.dart';
import 'package:troond/views/address/services/address_services.dart';
import 'package:troond/widget/toast/build_toast.dart';

import '../model/address_model.dart';

class AddressController extends ChangeNotifier {
  AddressServices addressServices = AddressServices();
  int? isLoading;

  Future deleteAddress({
    required int id,
    required BuildContext context,
  }) async {
    isLoading = id;
    notifyListeners();
    await addressServices.deleteAddress(id);
    isLoading = null;
    notifyListeners();
    BuildToast.success(title: "Deleted");
  }

  String type = "";
  bool isDefault = false;
  final addressKey = GlobalKey<FormState>();
  TextEditingController mainAdress = TextEditingController();
  TextEditingController phone = TextEditingController();
  CitiesModel? citiesModel;
  String city = "";
  chooseState(CitiesModel value) {
    citiesModel = value;
    city = "";
    notifyListeners();
  }

  chooseCity(String value) {
    city = value;
    notifyListeners();
  }

  void choosetype(String newValue) {
    type = newValue;
    notifyListeners();
  }

  void editType({required String newValue, required String type}) {
    type = newValue;
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  //* add
  Future addAddress({required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    if (!SharedPref.isLogin()) {
      Navigator.of(context).pushNamed(AppRoutes.loginScreen);
    } else {
      if (addressKey.currentState!.validate()) {
        if (type.isEmpty) {
          BuildToast.success(title: local.chooseType);
        } else if (citiesModel == null) {
          BuildToast.success(title: local.chooseState);
        } else if (city.isEmpty) {
          BuildToast.success(title: local.chooseCity);
        } else {
          isLoading = 0;
          notifyListeners();
          Map result = await addressServices.addAddress(
            type: type,
            mainAdress: mainAdress.text,
            state: citiesModel!.governorate,
            city: city,
            isDefault: isDefault,
            phone: phone.text,
          );
          if (result.containsKey("success") && result["success"] == true) {
            isLoading = null;
            type = "";
            mainAdress.clear();
            phone.clear();
            citiesModel = null;
            city = "";
            notifyListeners();
            Navigator.pop(context);
          } else {
            isLoading = null;
            notifyListeners();
            BuildToast.success(title: local.error);
          }
        }
      }
    }
  }

  final editAddressKey = GlobalKey<FormState>();

  Future updateAddress({
    required AddressModel address,
    required BuildContext context,
  }) async {
    if (editAddressKey.currentState!.validate()) {
      isLoading = address.id;
      notifyListeners();
      await addressServices.updateAddress(addressModel: address);
      isLoading = null;
      notifyListeners();
      Navigator.pop(context);
    }
  }

  Future markAsDefault({
    required bool isDefault,
    required int addressId,
  }) async {
    await addressServices.markAsDefalt(
      isDefault: isDefault,
      id: addressId,
    );
    notifyListeners();
  }
}
