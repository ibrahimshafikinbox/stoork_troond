// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/be_supplier/services/be_supplier_services.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/widget/toast/build_toast.dart';

import '../../../config/app_local/app_local.dart';

class BeSupplierController extends ChangeNotifier {
  BeSupplierServcies beSupplierServcies = BeSupplierServcies();
  TextEditingController region = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController phone = TextEditingController();
  String cityKey = "";
  var createKey = GlobalKey<FormState>();
  int? isLoading;
  Future createSupplier(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);
    if (createKey.currentState!.validate()) {
      isLoading = 0;
      notifyListeners();
      Map result = await beSupplierServcies.createSupplier(
        region: region.text,
        email: email.text,
        fullName: fullName.text,
        companyName: companyName.text,
        phone: cityKey + phone.text,
      );
      isLoading = null;
      notifyListeners();
      if (result.isNotEmpty) {
        Navigator.of(context).pushNamed(
          AppRoutes.verifiyEmail,
          arguments: result["id"],
        );
      } else {
        BuildToast.success(title: local.errorTryAgain);
      }
    }
  }

  var emailKey = GlobalKey<FormState>();
  TextEditingController code = TextEditingController();

  Future verfiyEmail(
    BuildContext context,
    int id,
  ) async {
    var local = MyLocalizations.getLocal(context);
    if (emailKey.currentState!.validate()) {
      isLoading = 1;
      notifyListeners();
      bool result = await beSupplierServcies.verfiyEmail(
        email: email.text,
        code: code.text,
      );
      isLoading = null;
      notifyListeners();
      if (result == true) {
        Navigator.of(context).pushNamed(AppRoutes.companyInfo, arguments: id);
      } else {
        BuildToast.success(title: local.errorTryAgain);
      }
    }
  }

  var companyInfoKey = GlobalKey<FormState>();
  TextEditingController employees = TextEditingController();
  int isManufacturer = 0;
  CategoryModel? categoryModel;
  chooseCategory(CategoryModel value) {
    categoryModel = value;
    notifyListeners();
  }

  chooseManufacturer(int value) {
    isManufacturer = value;
    notifyListeners();
  }

  Future verfiyCompanyInfo({
    required BuildContext context,
    required int supplierId,
  }) async {
    var local = MyLocalizations.getLocal(context);
    if (companyInfoKey.currentState!.validate()) {
      isLoading = 2;
      notifyListeners();
      bool result = await beSupplierServcies.verfiyCompanyInfo(
        categoryId: categoryModel!.id,
        employees: int.parse(employees.text),
        isManufacturer: isManufacturer == 0 ? true : false,
        supplierId: supplierId,
      );
      isLoading = null;
      notifyListeners();
      if (result == true) {
        Navigator.of(context).pushNamed(
          AppRoutes.bankInfo,
          arguments: supplierId,
        );
      } else {
        BuildToast.success(title: local.errorTryAgain);
      }
    }
  }

  var bankInfoKey = GlobalKey<FormState>();
  TextEditingController swift = TextEditingController();
  TextEditingController iban = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountName = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController accountCity = TextEditingController();

  Future verfiyBankInfo({
    required BuildContext context,
    required int supplierId,
  }) async {
    var local = MyLocalizations.getLocal(context);
    if (bankInfoKey.currentState!.validate()) {
      isLoading = 3;
      notifyListeners();
      bool result = await beSupplierServcies.verfiyBankInfo(
        supplierId: supplierId,
        swift: swift.text,
        iban: iban.text,
        bankName: bankName.text,
        accountName: accountName.text,
        accountNumber: accountNumber.text,
        accountCity: accountCity.text,
      );
      isLoading = null;
      notifyListeners();
      if (result == true) {
        Navigator.of(context).pushNamed(AppRoutes.doneStep);
      } else {
        BuildToast.success(title: local.errorTryAgain);
      }
    }
  }
}
