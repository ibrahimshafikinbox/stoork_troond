import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/valid/app_validation.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../../widget/input/build_input.dart';
import '../../controller/be_supplier_controller.dart';

class VerfiyEmail extends StatelessWidget {
  const VerfiyEmail({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    BeSupplierController beSupplierController =
        Provider.of<BeSupplierController>(context);
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.beSupplier)),
      body: Form(
        key: beSupplierController.emailKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        local.verifiy,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SvgWidget(svgName: "verfy_mail.svg"),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: Text(
                              local.pleaseEnterTheFourDigit,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColor.c3D3D3D,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),

                    //* Verification Code
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                local.verificationCode,
                                style: const TextStyle(
                                  color: AppColor.c121212,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            subtitle: BuildInput(
                              controller: beSupplierController.code,
                              validator: AppValidation.required(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        //* resend
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: SizedBox(
                        //     width: 200,
                        //     child: BuildTextBtn(
                        //       color: AppColor.whiteF1,
                        //       onTap: () {},
                        //       text: "Resend (57s)",
                        //       textColor: AppColor.grey7E,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            beSupplierController.isLoading == 1
                ? const LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: BuildTextBtn(
                        color: AppColor.main,
                        onTap: () {
                          beSupplierController.verfiyEmail(context, id);
                        },
                        text: local.next,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
