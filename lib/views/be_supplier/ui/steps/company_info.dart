import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/be_supplier/controller/be_supplier_controller.dart';
import 'package:troond/views/categories/services/categories_services.dart';
import 'package:troond/views/home/model/category_model.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/valid/app_validation.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../../widget/input/build_input.dart';

class CompanyInfo extends StatelessWidget {
  const CompanyInfo({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    BeSupplierController beSupplierController =
        Provider.of<BeSupplierController>(context);
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.beSupplier)),
      body: Form(
        key: beSupplierController.companyInfoKey,
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
                        local.companyInfo,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    //* category
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.category,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        subtitle: FutureBuilder<List<CategoryModel>>(
                          future: CategoriesServices().getCategories(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox();
                            } else {
                              return PopupMenuButton(
                                color: AppColor.white,
                                position: PopupMenuPosition.under,
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: AppColor.cC3C3C3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  title: Text(
                                    beSupplierController.categoryModel == null
                                        ? ""
                                        : beSupplierController
                                            .categoryModel!.name,
                                  ),
                                  trailing:
                                      const Icon(BootstrapIcons.chevron_down),
                                ),
                                itemBuilder: (context) {
                                  return [
                                    for (int i = 0; i < 10; i++)
                                      PopupMenuItem(
                                        onTap: () {
                                          beSupplierController.chooseCategory(
                                            snapshot.data![i],
                                          );
                                        },
                                        child: Text(snapshot.data![i].name),
                                      ),
                                  ];
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),

                    //* Number of Employees
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            local.numberOfEmployees,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: BuildInput(
                          controller: beSupplierController.employees,
                          validator: AppValidation.required(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                    ),

                    //* Manufacturer
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            local.areYouAManufacturerOrADistributor,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        subtitle: ListView.builder(
                          itemCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return RadioListTile<int>(
                              value: index,
                              groupValue: beSupplierController.isManufacturer,
                              onChanged: (value) {
                                beSupplierController.chooseManufacturer(value!);
                              },
                              title: Text(
                                index == 0
                                    ? local.manufacturer
                                    : local.distributor,
                              ),
                              activeColor: AppColor.cDBDBDB,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: BuildTextBtn(
                  color: AppColor.main,
                  onTap: () {
                    beSupplierController.verfiyCompanyInfo(
                      context: context,
                      supplierId: id,
                    );
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


                    // Padding(
                    //   padding: const EdgeInsets.all(4.0),
                    //   child: ListTile(
                    //     title: const Padding(
                    //       padding: EdgeInsets.only(bottom: 5),
                    //       child: Text(
                    //         "Number of Employees",
                    //         style: TextStyle(
                    //           color: AppColor.color121212,
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 18,
                    //         ),
                    //       ),
                    //     ),
                    //     subtitle: PopupMenuButton(
                    //       color: AppColor.white,
                    //       position: PopupMenuPosition.under,
                    //       child: ListTile(
                    //         shape: RoundedRectangleBorder(
                    //           side: const BorderSide(color: AppColor.border),
                    //           borderRadius: BorderRadius.circular(4),
                    //         ),
                    //         title: const Text(""),
                    //         trailing: const Icon(BootstrapIcons.chevron_down),
                    //       ),
                    //       itemBuilder: (context) {
                    //         return [
                    //           for (int i = 0;
                    //               i < BeSupplierHelper.numberOfEmployess.length;
                    //               i++)
                    //             PopupMenuItem(
                    //               child: Text(
                    //                 BeSupplierHelper.numberOfEmployess[i],
                    //               ),
                    //             ),
                    //         ];
                    //       },
                    //     ),
                    //   ),
                    // ),