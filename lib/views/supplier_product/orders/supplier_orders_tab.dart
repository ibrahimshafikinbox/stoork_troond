import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../widget/input/build_input.dart';

class SupplierOrdersTab extends StatelessWidget {
  const SupplierOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.orders)),
      body: Column(
        children: [
          //* search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: BuildInput(
                      hintText: local.search,
                      iconButton: const Icon(
                        BootstrapIcons.search,
                        color: AppColor.c717171,
                        size: 25,
                      ),
                      onChange: (value) {
                        //! search
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //! filter
                      },
                      child: SizedBox(
                        height: 55,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: AppColor.cDBDBDB),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              BootstrapIcons.sliders,
                              color: AppColor.main,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        //! add
                      },
                      child: SizedBox(
                        height: 55,
                        child: Card(
                          color: AppColor.main,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.add,
                              color: AppColor.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //* orders
        ],
      ),
    );
  }
}
