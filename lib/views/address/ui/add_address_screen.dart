import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/address/controller/address_controller.dart';
import 'package:troond/views/address/model/cities_model.dart';
import 'package:troond/views/address/services/address_services.dart';
import 'package:troond/views/address/ui/searchable_address_sheet.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/text/build_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../config/app_local/app_local.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = Provider.of<AddressController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: addressController.addressKey,
        child: ListView(
          children: [
            Center(
              child: BuildHeader(text: local.addAddress),
            ),

            //* Type
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      addressController.choosetype("home");
                    },
                    child: Text(local.home),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      addressController.choosetype("work");
                    },
                    child: Text(local.work),
                  ),
                  PopupMenuItem(
                    child: Text(local.other),
                    onTap: () {
                      addressController.choosetype("other");
                    },
                  ),
                ];
              },
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    local.type,
                    style: const TextStyle(
                      color: AppColor.c121212,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                subtitle: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColor.cDBDBDB),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          addressController.type.isEmpty
                              ? local.type
                              : addressController.type,
                        ),
                        const FaIcon(FontAwesomeIcons.chevronDown)
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 5),

            FutureBuilder<List<CitiesModel>>(
              future: AddressServices().getLocalCities(),
              builder: (context, snapshot) {
                List<CitiesModel> data = snapshot.hasData ? snapshot.data! : [];

                return Row(
                  children: [
                    //* State
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          if (data.isEmpty) return;
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) {
                              return SearchableAddressSelectorSheet(
                                title: local.state,
                                items: data.map((e) => e.governorate).toList(),
                                selectedItem: addressController
                                    .citiesModel?.governorate,
                                onSelected: (selectedGovernorate) {
                                  final matched = data.firstWhere(
                                    (e) => e.governorate == selectedGovernorate,
                                    orElse: () => data.first,
                                  );
                                  addressController.chooseState(matched);
                                },
                              );
                            },
                          );
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            local.state,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColor.cDBDBDB),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          title: Text(
                            addressController.citiesModel == null
                                ? local.state
                                : addressController.citiesModel!.governorate,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const FaIcon(FontAwesomeIcons.chevronDown),
                        ),
                      ),
                    ),
                    //* City
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          if (addressController.citiesModel == null) {
                            if (data.isNotEmpty) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return SearchableAddressSelectorSheet(
                                    title: local.state,
                                    items: data.map((e) => e.governorate).toList(),
                                    selectedItem: addressController
                                        .citiesModel?.governorate,
                                    onSelected: (selectedGovernorate) {
                                      final matched = data.firstWhere(
                                        (e) => e.governorate == selectedGovernorate,
                                        orElse: () => data.first,
                                      );
                                      addressController.chooseState(matched);
                                    },
                                  );
                                },
                              );
                            }
                          } else {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return SearchableAddressSelectorSheet(
                                  title: local.city,
                                  items: addressController.citiesModel!.cities,
                                  selectedItem: addressController.city.isNotEmpty
                                      ? addressController.city
                                      : null,
                                  onSelected: (selectedCity) {
                                    addressController.chooseCity(selectedCity);
                                  },
                                );
                              },
                            );
                          }
                        },
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            local.city,
                            style: const TextStyle(
                              color: AppColor.c121212,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        subtitle: ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColor.cDBDBDB),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          title: Text(
                            addressController.citiesModel == null
                                ? local.city
                                : addressController.city,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: const FaIcon(FontAwesomeIcons.chevronDown),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 5),

            //* Address
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  local.address,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              subtitle: BuildInput(
                controller: addressController.mainAdress,
                hintText: "مثال شارع الارسال مقايل محلات الكرامه للحلويات ",
                validator: AppValidation.required(),
              ),
            ),

            const SizedBox(height: 5),

            //* phone
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 10),
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
                controller: addressController.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: "0599302010",
                validator: AppValidation.required(),
              ),
            ),

            const SizedBox(height: 20),
            //* add
            addressController.isLoading == 0
                ? const LoadingWidget()
                : BuildTextBtn(
                    color: AppColor.main,
                    onTap: () {
                      addressController.addAddress(context: context);
                    },
                    text: local.addNewAddress,
                  ),
          ],
        ),
      ),
    );
  }
}
