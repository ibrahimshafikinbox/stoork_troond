// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/app_media/app_media.dart';
import 'package:troond/views/brands/model/brand_model.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/supplier_product/services/supplier_product_services.dart';
import 'package:troond/widget/toast/build_toast.dart';
import '../../../config/routes/app_routes.dart';

class SupplierProductController extends ChangeNotifier {
  SupplierProductServices productServices = SupplierProductServices();
  int productId = 0;

  //* search
  List<ProductPreview> products = [];
  TextEditingController searchText = TextEditingController();
  search(List<ProductPreview> data) {
    products = data.where((element) {
      return element.name.toLowerCase().contains(searchText.text) ||
          element.description.toLowerCase().contains(searchText.text);
    }).toList();
    notifyListeners();
  }

  //* index
  int? loading;
  int index = 0;
  void changeIndex(int value, BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    if (productId == 0) {
      BuildToast.success(title: local.youShouldCreateProductFirst);
    } else {
      index = value;
      notifyListeners();
    }
  }

  void changeIndex2(int value) {
    index = value;
    notifyListeners();
  }

  void clear(BuildContext context) {
    productId = 0;
    index = 0;
    Navigator.pop(context);
    notifyListeners();
  }

  //* genral info
  var generalKey = GlobalKey<FormState>();
  TextEditingController unit = TextEditingController();
  TextEditingController basePrice = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController material = TextEditingController();
  TextEditingController discount = TextEditingController();

  CategoryModel? categoryModel;
  CategoryModel? categorychild;
  BrandModel? brandModel;
  void chooseCategory(CategoryModel value) {
    categoryModel = value;
    notifyListeners();
  }

  void chooseCategoryChild(CategoryModel value) {
    categorychild = value;
    notifyListeners();
  }

  void chooseBrand(BrandModel value) {
    brandModel = value;
    notifyListeners();
  }

  Future addProduct(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);

    if (generalKey.currentState!.validate()) {
      if (categorychild == null) {
        BuildToast.success(title: local.chooseCategory);
      } else if (brandModel == null) {
        BuildToast.success(title: local.chooseBrand);
      } else {
        loading = 0;
        notifyListeners();
        int result = await productServices.addProduct(
          unit: unit.text,
          basePrice: basePrice.text,
          price: price.text,
          name: name.text,
          description: description.text,
          categoryId: categorychild!.id,
          brandId: brandModel!.id,
          material: material.text,
          discount: discount.text,
        );
        if (result != 0) {
          loading = null;
          categoryModel = null;
          categorychild = null;
          brandModel = null;
          productId = result;
          index = 1;
          notifyListeners();
        } else {
          loading = null;
          BuildToast.success(title: local.error);
          notifyListeners();
        }
      }
    }
  }

  void addImage(String order) {
    AppMedia().pickImage().then((value) async {
      if (value != null) {
        loading = 1;
        notifyListeners();
        await productServices.addImage(
          id: productId,
          image: value.path,
          order: order,
        );
        loading = null;
        notifyListeners();
      }
    });
  }

  Future deleteProduct(int id, BuildContext context) async {
    await productServices.deleteProduct(id);
    notifyListeners();
    Navigator.pop(context);
  }

  void navEdit({
    required BuildContext context,
    required int id,
  }) {
    Navigator.of(context).pushNamed(
      AppRoutes.addProductScreen,
    );
    productId = id;
    notifyListeners();
  }

  Future deleteImage(int id) async {
    loading = id;
    notifyListeners();
    await productServices.deleteImage(id);
    loading = null;
    notifyListeners();
  }

  Future setImage({required int imageId}) async {
    loading = imageId;
    notifyListeners();
    await productServices.setImage(imageId: imageId, productId: productId);
    loading = null;
    notifyListeners();
  }

  //* size  color
  TextEditingController size = TextEditingController();
  TextEditingController count = TextEditingController();

  Future addSize({required String color, required BuildContext context}) async {
    var local = MyLocalizations.getLocal(context);
    if (size.text.isEmpty || count.text.isEmpty) {
      BuildToast.success(title: local.emptyValue);
    } else {
      await productServices.addSize(
        porductId: productId,
        color: color,
        size: size.text,
        count: count.text,
      );
      notifyListeners();
      Navigator.pop(context);
    }
  }

  Future addColor({
    required String color,
    required BuildContext context,
    required String size,
  }) async {
    var local = MyLocalizations.getLocal(context);
    if (count.text.isEmpty) {
      BuildToast.success(title: local.emptyValue);
    } else {
      await productServices.addSize(
        porductId: productId,
        color: color,
        size: size,
        count: count.text,
      );
      notifyListeners();
      Navigator.pop(context);
    }
  }

  Future deleteColor(int id) async {
    await productServices.deleteColor(id);
    notifyListeners();
  }

  //* overview
  TextEditingController descOverview = TextEditingController();
  TextEditingController headerOverview = TextEditingController();
  var overviewKey = GlobalKey<FormState>();

  Future addNewOverview(BuildContext context) async {
    if (overviewKey.currentState!.validate()) {
      loading = 6;
      notifyListeners();
      await productServices.addNewOverview(
        description: descOverview.text,
        header: headerOverview.text,
        productId: productId,
      );
      loading = null;
      descOverview.clear();
      headerOverview.clear();
      Navigator.pop(context);
      notifyListeners();
    }
  }

  var opitionKey = GlobalKey<FormState>();
  TextEditingController nameOption = TextEditingController();
  TextEditingController valueOption = TextEditingController();
  Future addNewOption({
    required BuildContext context,
    required int order,
  }) async {
    if (opitionKey.currentState!.validate()) {
      loading = 7;
      notifyListeners();
      await productServices.addNewOption(
        name: nameOption.text,
        order: order,
        value: valueOption.text,
        productId: productId,
      );
      loading = null;
      nameOption.clear();
      valueOption.clear();
      Navigator.pop(context);
      notifyListeners();
    }
  }

  var editKey = GlobalKey<FormState>();

  Future editProduct(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);
    if (editKey.currentState!.validate()) {
      if (categorychild == null) {
        BuildToast.success(title: local.chooseCategory);
      } else if (brandModel == null) {
        BuildToast.success(title: local.chooseBrand);
      } else {
        loading = 0;
        notifyListeners();
        await productServices.editProduct(
          id: productId,
          unit: unit.text,
          basePrice: basePrice.text,
          price: price.text,
          name: name.text,
          description: description.text,
          categoryId: categorychild!.id,
          brandId: brandModel!.id,
          material: material.text,
          discount: discount.text,
        );
        loading = null;
        categoryModel = null;
        categorychild = null;
        brandModel = null;
        index = 1;
        notifyListeners();
      }
    }
  }

  //* suggestion
  TextEditingController categoryName = TextEditingController();
  TextEditingController categoryNote = TextEditingController();
  var addNewCategoryKey = GlobalKey<FormState>();

  Future addNewCategory(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);
    if (addNewCategoryKey.currentState!.validate()) {
      await productServices.addNewCategory(
        name: name.text,
        note: categoryNote.text,
      );
      BuildToast.success(title: local.addSuggestion);
      categoryName.clear();
      Navigator.pop(context);
    }
  }

  TextEditingController categoryName2 = TextEditingController();
  TextEditingController categoryNote2 = TextEditingController();
  var addNewCategoryKey2 = GlobalKey<FormState>();
  Future addNewSubcategory(BuildContext context) async {
    var local = MyLocalizations.getLocal(context);
    if (addNewCategoryKey2.currentState!.validate()) {
      await productServices.addNewSubcategory(
        categoryId: categoryModel!.id,
        name: categoryName2.text,
        note: categoryNote2.text,
      );
      BuildToast.success(title: local.addSuggestion);
      categoryName2.clear();
      categoryNote2.clear();
      Navigator.pop(context);
    }
  }
}
