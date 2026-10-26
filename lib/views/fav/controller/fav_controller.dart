// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:troond/config/app_const/shared_const.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/product/model/product_preview.dart';
import '../../../config/app_local/app_local.dart';
import '../../../widget/toast/build_toast.dart';
import '../services/fav_services.dart';

class FavController extends ChangeNotifier {
  FavServices favServices = FavServices();
  int? isAdding;
  final Set<int> _favProductIds = {};
  List<ProductPreview> _favProducts = [];
  bool _isInitialized = false;

  FavController() {
    loadFavs();
  }

  Set<int> get favProductIds => _favProductIds;
  List<ProductPreview> get favProducts => _favProducts;
  bool get isInitialized => _isInitialized;

  bool isFavorite(int productId) => _favProductIds.contains(productId);

  Future<void> loadFavs() async {
    try {
      // 1. Load local cache first for instant display
      List<ProductPreview> localFavs = await favServices.getLocalFav();
      if (localFavs.isNotEmpty) {
        _favProducts = List.from(localFavs);
        _favProductIds.clear();
        for (var p in localFavs) {
          _favProductIds.add(p.id);
        }
        _isInitialized = true;
        notifyListeners();
      }

      // 2. Fetch remote if logged in
      if (SharedPref.isLogin() &&
          SharedPref.getToken() != null &&
          SharedPref.getToken()!.isNotEmpty) {
        List<ProductPreview> remoteFavs = await favServices.getFavList();
        _favProducts = List.from(remoteFavs);
        _favProductIds.clear();
        for (var p in remoteFavs) {
          _favProductIds.add(p.id);
        }
        _isInitialized = true;
        notifyListeners();
      } else {
        _isInitialized = true;
        notifyListeners();
      }
    } catch (_) {
      _isInitialized = true;
      notifyListeners();
    }
  }

  void addToFav({
    required int productId,
    int? productVariantId,
    required BuildContext context,
  }) async {
    var local = MyLocalizations.getLocal(context);

    if (!SharedPref.isLogin() ||
        SharedPref.getToken() == null ||
        SharedPref.getToken()!.isEmpty) {
      BuildToast.error(
          title: "يرجى تسجيل الدخول أولاً لإضافة المنتجات للمفضلة");
      Navigator.of(context).pushNamed(AppRoutes.loginScreen);
      return;
    }

    isAdding = productId;
    _favProductIds.add(productId);
    notifyListeners();

    bool result =
        await favServices.addToFav(productId, productVariantId: productVariantId);

    if (result == true) {
      await loadFavs();
      isAdding = null;
      notifyListeners();
      BuildToast.success(title: local.addedToFavorites);
    } else {
      _favProductIds.remove(productId);
      isAdding = null;
      notifyListeners();
      BuildToast.error(title: local.error);
    }
  }

  Future<void> delete({
    required int productId,
    BuildContext? context,
    bool showToast = false,
  }) async {
    // 1. Optimistic removal: remove immediately and smoothly without reloading
    _favProductIds.remove(productId);
    _favProducts.removeWhere((item) => item.id == productId);
    await _updateLocalCache();
    notifyListeners();

    // 2. Optional toast feedback if requested
    if (showToast && context != null) {
      var local = MyLocalizations.getLocal(context);
      BuildToast.success(title: local.removedToFavorites);
    }

    // 3. Inform server in background
    try {
      bool success = await favServices.deleteFromFav(productId);
      if (kDebugMode) {
        print("❤️ [FavController delete] Server delete result: $success for productId $productId");
      }
    } catch (e) {
      if (kDebugMode) print("❤️ [FavController delete] Server delete error: $e");
    }
  }

  Future<void> _updateLocalCache() async {
    try {
      if (_favProducts.isEmpty) {
        await SharedPref.setKey(
          value: jsonEncode({"data": []}),
          key: SharedConsts.fav,
        );
        return;
      }
      var cache = SharedPref.getKey(key: SharedConsts.fav);
      if (cache != null && cache.isNotEmpty) {
        var fav = jsonDecode(cache);
        if (fav["data"] is List) {
          (fav["data"] as List).removeWhere((element) {
            try {
              int? id = element["product"]?["id"] ?? element["product_id"];
              return id != null && !_favProductIds.contains(id);
            } catch (_) {
              return false;
            }
          });
          await SharedPref.setKey(
            value: jsonEncode(fav),
            key: SharedConsts.fav,
          );
        }
      }
    } catch (_) {}
  }
}
