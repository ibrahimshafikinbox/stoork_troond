import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/app_const/app_method.dart';
import 'package:troond/widget/input/build_input.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../controller/filter_controller.dart';
import '../../model/filter_model.dart';

class FilterColorScreen extends StatelessWidget {
  const FilterColorScreen({super.key, required this.filterModel});
  final FilterModel filterModel;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    var filterController = Provider.of<FilterController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(local.colors),
        actions: [
          TextButton(
            onPressed: () {
              //*
            },
            child: Text(
              local.reset,
              style: const TextStyle(color: AppColor.c223263),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //* search
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuildInput(
              hintText: local.search,
              iconButton: const Icon(
                BootstrapIcons.search,
                color: AppColor.main,
                size: 20,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.65,
              ),
              itemCount: filterModel.colors.length,
              itemBuilder: (context, index) {
                var item = filterModel.colors[index];
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppMethod().hexToColor(item),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: BuildTextBtn(
              onTap: () {
                filterController.filter(
                  context: context,
                  filterModel: filterModel,
                );
              },
              color: AppColor.main,
              text: local.apply,
            ),
          ),
        ],
      ),
    );
  }
}
