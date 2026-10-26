import 'package:flutter/material.dart';
import 'package:troond/views/filter/model/filter_model.dart';
import 'package:troond/widget/input/build_input.dart';

import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';

class FilterPriceScreen extends StatelessWidget {
  const FilterPriceScreen({
    super.key,
    required this.filterModel,
  });
  final FilterModel filterModel;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(local.price),
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
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          local.min,
                          style: const TextStyle(
                            color: AppColor.c717171,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const BuildInput(
                        borderColor: AppColor.cB8B8B8,
                        inputType: TextInputType.number,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Text(
                  local.to,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.c121212,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          local.max,
                          style: const TextStyle(
                            color: AppColor.c717171,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const BuildInput(
                        borderColor: AppColor.cB8B8B8,
                        inputType: TextInputType.number,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
