import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/be_supplier/controller/be_supplier_controller.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../config/valid/app_validation.dart';
import '../../../widget/input/build_input.dart';

class BeSupplierScreen extends StatelessWidget {
  const BeSupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BeSupplierController beSupplierController =
        Provider.of<BeSupplierController>(context);
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.beSupplier)),
      body: Form(
        key: beSupplierController.createKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  local.generalInfo,
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
                      local.country,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  subtitle: BuildInput(
                    hintText: local.country,
                    controller: beSupplierController.region,
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
                      local.email,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  subtitle: BuildInput(
                    hintText: local.email,
                    controller: beSupplierController.email,
                    validator: AppValidation.email(),
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
                      local.fullName,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  subtitle: BuildInput(
                    hintText: local.fullName,
                    controller: beSupplierController.fullName,
                    validator: AppValidation.required(),
                  ),
                ),
              ),

              //* Company name
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      local.companyName,
                      style: const TextStyle(
                        color: AppColor.c121212,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  subtitle: BuildInput(
                    hintText: local.companyName,
                    controller: beSupplierController.companyName,
                    validator: AppValidation.required(),
                  ),
                ),
              ),

              //* Phone number
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
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
                    controller: beSupplierController.phone,
                    hintText: local.phoneNumber,
                    validator: AppValidation.phone(),
                    iconButton: CountryCodePicker(
                      onChanged: (value) {
                        beSupplierController.cityKey = value.code!;
                      },
                      initialSelection: 'TR',
                      showDropDownButton: true,
                      showFlag: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.verifiyEmail,
                      arguments: 0,
                    );
                  },
                  child: Text(
                    local.iAlreadyHaveTheActivationCode,
                    style: const TextStyle(
                      color: AppColor.c29296E,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              beSupplierController.isLoading == 0
                  ? const LoadingWidget()
                  : BuildTextBtn(
                      color: AppColor.main,
                      onTap: () {
                        beSupplierController.createSupplier(context);
                      },
                      text: local.next,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
