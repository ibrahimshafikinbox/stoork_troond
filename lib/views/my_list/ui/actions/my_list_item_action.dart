import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/my_list/controller/my_list_controller.dart';

import '../../../../config/app_local/app_local.dart';

class MyListItemAction extends StatelessWidget {
  const MyListItemAction({
    super.key,
    required this.myListController,
    required this.itemId,
  });
  final MyListController myListController;
  final int itemId;
  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return SafeArea(
      child: SizedBox(
        height: 150,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: AppColor.c121212,
                  ),
                ),
              ),

              //* Add to another list
              // ListTile(
              //   onTap: () {
              //     // Navigator.pop(context);
              //     // showModalBottomSheet(
              //     //   context: context,
              //     //   backgroundColor: AppColor.white,
              //     //   builder: (context) {
              //     //     return AddToAnotherList(
              //     //       myListController: myListController,
              //     //       productId: ,
              //     //     );
              //     //   },
              //     // );
              //   },
              //   title: const Text(
              //     "Add to another list",
              //     style: TextStyle(
              //       color: AppColor.color3D3D3D,
              //       fontWeight: FontWeight.w500,
              //       fontSize: 16,
              //     ),
              //   ),
              //   minLeadingWidth: 0,
              //   leading: const Icon(
              //     Icons.arrow_forward,
              //     color: AppColor.c717171,
              //   ),
              // ),

              // const Divider(),

              //* View similar items
              // const ListTile(
              //   title: Text(
              //     "View similar items",
              //     style: TextStyle(
              //       color: AppColor.color3D3D3D,
              //       fontWeight: FontWeight.w500,
              //       fontSize: 16,
              //     ),
              //   ),
              //   minLeadingWidth: 0,
              //   leading: Icon(
              //     Icons.arrow_forward,
              //     color: AppColor.c717171,
              //   ),
              // ),

              const Divider(),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      myListController.removeItem(
                        id: itemId,
                        context: context,
                      );
                    },
                    icon: const Icon(
                      BootstrapIcons.trash3,
                      color: AppColor.cFA4040,
                    ),
                    label: Text(
                      local.delete,
                      style: const TextStyle(
                        color: AppColor.cFA4040,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
