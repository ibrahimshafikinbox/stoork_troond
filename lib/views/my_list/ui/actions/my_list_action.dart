import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/my_list/model/my_list_model.dart';
import '../../../../config/app_local/app_local.dart';
import '../../controller/my_list_controller.dart';

class MyListAction extends StatelessWidget {
  const MyListAction({
    super.key,
    required this.myListController,
    required this.myListModel,
  });
  final MyListController myListController;
  final MyListModel myListModel;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Material(
      color: AppColor.white,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushNamed(
                        AppRoutes.editListScreen,
                        arguments: [
                          myListModel.name,
                          myListModel.id,
                        ],
                      );
                    },
                    icon: const Icon(
                      BootstrapIcons.pencil_square,
                      color: AppColor.c3D3D3D,
                    ),
                    label: Text(
                      local.edit,
                      style: const TextStyle(
                        color: AppColor.c3D3D3D,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      myListController.deleteList(
                        id: myListModel.id,
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
