import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/my_list/controller/my_list_controller.dart';
import 'package:troond/views/my_list/services/my_list_services.dart';
import 'package:troond/views/my_list/ui/all/all_list_tab.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../model/my_list_model.dart';
import 'my_list_tab.dart';

class MyListsScreen extends StatelessWidget {
  const MyListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyListController myListController = Provider.of<MyListController>(context);
    var local = MyLocalizations.getLocal(context);
    return FutureBuilder<List<MyListModel>>(
      future: MyListServices().getAllLists(),
      builder: (context, snapshot) {
        var cache = SharedPref.getKey(key: SharedConsts.myList);
        if (cache == null) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: AppColor.c121212),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.addListScreen);
                  },
                  child: Text(
                    "+${local.create}",
                    style: const TextStyle(
                      color: AppColor.main,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: const LoadingWidget(),
          );
        } else {
          var data = jsonDecode(cache);
          List<MyListModel> json = [];
          for (var element in data["data"]) {
            json.add(MyListModel.fromJson(element));
          }
          var result = snapshot.hasData ? snapshot.data! : json;
          return DefaultTabController(
            length: result.length + 1,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(color: AppColor.c121212),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.addListScreen);
                    },
                    child: Text(
                      "+${local.create}",
                      style: const TextStyle(
                        color: AppColor.main,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                bottom: TabBar(
                  indicatorColor: AppColor.main,
                  labelColor: AppColor.main,
                  unselectedLabelColor: AppColor.c7E859B,
                  isScrollable: true,
                  tabs: [
                    Tab(text: local.all),
                    for (int i = 0; i < result.length; i++)
                      Tab(text: result[i].name),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  AllListTab(myListController: myListController),
                  for (int i = 0; i < result.length; i++)
                    MyListTab(
                      myListModel: result[i],
                      myListController: myListController,
                    ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
