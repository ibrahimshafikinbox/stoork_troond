import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/be_supplier/controller/be_supplier_controller.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/valid/app_validation.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../../widget/input/build_input.dart';

class BankInfo extends StatelessWidget {
  const BankInfo({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    BeSupplierController beSupplierController =
        Provider.of<BeSupplierController>(context);
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.beSupplier)),
      body: Form(
        key: beSupplierController.bankInfoKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        local.bankAccount,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Country/Region
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.bankName,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: BuildInput(
                          controller: beSupplierController.bankName,
                          validator: AppValidation.required(),
                        ),
                      ),
                    ),

                    //* Email
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.accountName,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: BuildInput(
                          controller: beSupplierController.accountName,
                          validator: AppValidation.required(),
                        ),
                      ),
                    ),

                    //* Full name
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.accountNumber,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: BuildInput(
                          controller: beSupplierController.accountNumber,
                          validator: AppValidation.required(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.iban,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: BuildInput(
                          controller: beSupplierController.iban,
                          validator: AppValidation.required(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.swift,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: BuildInput(
                          controller: beSupplierController.swift,
                          validator: AppValidation.required(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
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
                          controller: beSupplierController.accountCity,
                          validator: AppValidation.required(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            beSupplierController.isLoading == 3
                ? const LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: BuildTextBtn(
                        color: AppColor.main,
                        onTap: () {
                          beSupplierController.verfiyBankInfo(
                            context: context,
                            supplierId: id,
                          );
                        },
                        text: "Submit",
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
