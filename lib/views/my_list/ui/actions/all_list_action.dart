import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/my_list/controller/my_list_controller.dart';
import 'package:troond/views/my_list/model/my_list_model.dart';
import 'package:troond/views/my_list/services/my_list_services.dart';
import 'package:troond/widget/btn/text_btn.dart';
import 'package:troond/widget/loading/loading_widget.dart';

import '../../../../config/app_local/app_local.dart';

class AllListAction extends StatelessWidget {
  const AllListAction({
    super.key,
    required this.myListController,
    required this.productId,
  });
  final MyListController myListController;
  final int productId;

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Material(
      color: AppColor.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: SizedBox(
        height: 600,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  local.addToAnotherList,
                  style: const TextStyle(
                    color: AppColor.c3D3D3D,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: AppColor.c121212,
                  ),
                ),
              ),

              //* list

              SizedBox(
                height: 300,
                child: FutureBuilder<List<MyListModel>>(
                  future: MyListServices().getAllLists(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const LoadingWidget();
                    } else {
                      var allList = snapshot.data!;
                      return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: allList.length,
                        itemBuilder: (context, index) {
                          var myList = allList[index];
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return ListTile(
                                title: Text(
                                  myList.name,
                                  style: const TextStyle(
                                    color: AppColor.c3D3D3D,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  "${local.items}(${myList.items.length})",
                                  style: const TextStyle(
                                    color: AppColor.c717171,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Checkbox(
                                  value: myListController.isActive,
                                  activeColor: AppColor.main,
                                  checkColor: AppColor.main,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      myListController.chooseList(
                                        value: value!,
                                        id: myList.id,
                                      );
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),

              //* actions
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.cDADCE3,
                        fixedSize: const Size(500, 50),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed(
                          AppRoutes.addListScreen,
                        );
                      },
                      icon: const CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColor.white,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: AppColor.c717171,
                          ),
                        ),
                      ),
                      label: Text(
                        local.createNewList,
                        style: const TextStyle(
                          color: AppColor.c3D3D3D,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BuildTextBtn(
                    color: AppColor.main,
                    onTap: () {
                      myListController.addMulitItemt(
                        productId: productId,
                        context: context,
                      );
                    },
                    text: local.save,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
