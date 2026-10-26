import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:troond/config/network/app_network.dart';

class BeSupplierServcies {
  Future<Map> createSupplier({
    required String region,
    required String email,
    required String fullName,
    required String companyName,
    required String phone,
  }) async {
    var url = AppNetWork.getBaseUrl("suppliers");
    var body = jsonEncode({
      "region": region,
      "email": email,
      "full_name": fullName,
      "company_name": companyName,
      "phone_number": phone,
    });

    http.Response response = await http.post(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
    if (response.statusCode == 201) {
      var result = jsonDecode(response.body);
      return result["data"];
    } else {
      return {};
    }
  }

  Future verfiyEmail({required String code, required String email}) async {
    var url = AppNetWork.getBaseUrl("verifiy/supplier");
    var body = jsonEncode({"code": code, "email": email});

    http.Response response = await http.post(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future resendCode({required String email}) async {
    var url = AppNetWork.getBaseUrl("supplier/$email/resend");
    http.Response response = await http.get(
      url,
      headers: AppNetWork.headerAuth(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future verfiyCompanyInfo({
    required int supplierId,
    required int categoryId,
    required int employees,
    required bool isManufacturer,
  }) async {
    var url = AppNetWork.getBaseUrl("suppliers/$supplierId");
    var body = jsonEncode({
      "category_id": categoryId,
      "employees": employees,
      "is_manufacturer": isManufacturer,
    });

    http.Response response = await http.put(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future verfiyBankInfo({
    required int supplierId,
    required String swift,
    required String iban,
    required String bankName,
    required String accountName,
    required String accountNumber,
    required String accountCity,
  }) async {
    var url = AppNetWork.getBaseUrl("banks");
    var body = jsonEncode({
      "supplier_id": supplierId,
      "swift": swift,
      "iban": iban,
      "bank_name": bankName,
      "account_name": accountName,
      "account_number": accountNumber,
      "account_city": accountCity,
    });
    http.Response response = await http.post(
      url,
      headers: AppNetWork.headerAuth(),
      body: body,
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
