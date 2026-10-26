// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:troond/views/fav/services/fav_services.dart';
import 'package:troond/views/my_list/services/my_list_services.dart';
import 'package:troond/widget/toast/build_toast.dart';

import '../../../config/app_local/app_local.dart';

class MyListController extends ChangeNotifier {
  MyListServices myListServices = MyListServices();
  int? listLoading;

  TextEditingController listName = TextEditingController();
  final listKey = GlobalKey<FormState>();
  onChange() {
    notifyListeners();
  }

  Future addList({required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    if (listKey.currentState!.validate()) {
      listLoading = 0;
      notifyListeners();
      bool result = await myListServices.addList(listName.text);
      if (result == true) {
        listLoading = null;
        Navigator.pop(context);
        notifyListeners();
        BuildToast.success(title: local.addNewList);
      } else {
        listLoading = null;
        notifyListeners();
        BuildToast.success(title: local.error);
      }
    }
  }

  final editlistKey = GlobalKey<FormState>();
  Future editList({
    required BuildContext context,
    required int id,
    required String name,
  }) async {
    var local = MyLocalizations.getLocal(context);

    if (editlistKey.currentState!.validate()) {
      listLoading = 0;
      notifyListeners();
      bool result = await myListServices.editList(id: id, name: name);
      if (result == true) {
        listLoading = null;
        Navigator.pop(context);
        notifyListeners();
        BuildToast.success(title: local.editList);
      } else {
        listLoading = null;
        notifyListeners();
        BuildToast.success(title: local.error);
      }
    }
  }

  Future deleteList({required int id, required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    await myListServices.deleteList(id: id);
    Navigator.pop(context);
    notifyListeners();
    BuildToast.success(title: local.deletedList);
  }

  Future addItem({
    required int id,
    required int productId,
    required BuildContext context,
  }) async {
    var local = MyLocalizations.getLocal(context);
    listLoading = productId;
    notifyListeners();
    await myListServices.addItem(id: id, productId: productId);
    listLoading = null;
    notifyListeners();
    BuildToast.success(title: local.addItemToList);
  }

  Future removeItem({required int id, required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    listLoading = id;
    notifyListeners();
    await myListServices.removeItem(id);
    listLoading = null;
    Navigator.pop(context);
    notifyListeners();
    BuildToast.success(title: local.removeItemToList);
  }

  List<int> lists = [];
  bool isActive = false;
  void chooseList({required bool value, required int id}) {
    isActive = value;
    notifyListeners();
    if (isActive == true) {
      lists.add(id);
      notifyListeners();
    } else {
      lists.remove(id);
      notifyListeners();
    }
  }

  Future addMulitItemt({
    required int productId,
    required BuildContext context,
  }) async {
    for (var element in lists) {
      await myListServices.addItem(id: element, productId: productId);
      notifyListeners();
    }
    lists.clear();
    isActive = false;
    notifyListeners();
    Navigator.pop(context);
  }

  //* fav or all
  FavServices favServices = FavServices();
  void deleteFromFav({
    required int productId,
    required BuildContext context,
  }) async {
    var local = MyLocalizations.getLocal(context);
    await favServices.deleteFromFav(productId);
    notifyListeners();
    BuildToast.success(title:local.removedToFavorites);
  }
}
