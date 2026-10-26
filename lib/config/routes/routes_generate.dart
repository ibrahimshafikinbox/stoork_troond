import 'package:flutter/material.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/views/address/model/address_model.dart';
import 'package:troond/views/address/ui/edit_address_screen.dart';
import 'package:troond/views/auth/ui/login/login_screen.dart';
import 'package:troond/views/auth/ui/password/confirm_password_screen.dart';
import 'package:troond/views/auth/ui/password/forget_password_screen.dart';
import 'package:troond/views/auth/ui/register/register_screen.dart';
import 'package:troond/views/be_supplier/ui/be_supplier_screen.dart';
import 'package:troond/views/be_supplier/ui/steps/bank_info.dart';
import 'package:troond/views/be_supplier/ui/steps/company_info.dart';
import 'package:troond/views/be_supplier/ui/steps/done_step.dart';
import 'package:troond/views/be_supplier/ui/steps/verifiy_email.dart';
import 'package:troond/views/supplier_product/supplier_product_screen.dart';
import 'package:troond/views/brands/ui/all_brands_screen.dart';
import 'package:troond/views/brands/ui/brand_screen.dart';
import 'package:troond/views/cart/ui/cart_screen.dart';
import 'package:troond/views/categories/ui/parent_category_screen/view_parent_category.dart';
import 'package:troond/views/categories/ui/sub_category_screen/sub_category_screen.dart';
import 'package:troond/views/checkout/ui/change_address_screen.dart';
import 'package:troond/views/checkout/ui/checkout_done.dart';
import 'package:troond/views/checkout/ui/checkout_screen.dart';
import 'package:troond/views/fav/ui/fav_screen.dart';
import 'package:troond/views/filter/model/filter_model.dart';
import 'package:troond/views/filter/ui/brand/filter_brand_screen.dart';
import 'package:troond/views/filter/ui/category/filter_category_screen.dart';
import 'package:troond/views/filter/ui/color/filter_color.dart';
import 'package:troond/views/filter/ui/filter_screen.dart';
import 'package:troond/views/help/ui/help_screen.dart';
import 'package:troond/views/main_screen/ui/main_screen.dart';
import 'package:troond/views/splash/splash_screen.dart';
import 'package:troond/views/address/ui/add_address_screen.dart';
import 'package:troond/views/address/ui/address_screen.dart';
import 'package:troond/views/orders/model/order_model.dart';
import 'package:troond/views/orders/ui/review/review_product_screen.dart';
import 'package:troond/views/orders/ui/review/review_screen.dart';
import 'package:troond/views/product/model/product_preview.dart';
import 'package:troond/views/product/ui/product_list/prodcts_list_screen.dart';
import 'package:troond/views/product/ui/product_list/products_list_screen_2.dart';
import 'package:troond/views/product/ui/product_view/product_preview_screen.dart';
import 'package:troond/views/product/ui/products_grop/products_grop_screen.dart';
import 'package:troond/views/profile/ui/change_password/change_password_screen.dart';
import 'package:troond/views/profile/ui/edit_info/edit_profile_screen.dart';
import 'package:troond/views/profile/ui/edit_number/edit_number_screen.dart';
import 'package:troond/views/orders/ui/order_detilas/order_detilas_screen.dart';
import 'package:troond/views/orders/ui/orders_screen/orders_screen.dart';
import 'package:troond/views/profile/ui/payments/ui/payment_screen.dart';
import 'package:troond/views/profile/ui/payments/ui/recent_payment/recent_payment_screen.dart';
import '../../views/cart/model/product_cart.dart';
import '../../views/home/model/category_model.dart';
import '../../views/my_list/ui/my_list/add_list_screen.dart';
import '../../views/my_list/ui/my_list/edit_list_screen.dart';
import '../../views/my_list/ui/my_list/my_list_screen.dart';
import '../../views/profile/ui/payments/ui/payment_processing/payment_processing_screen.dart';
import '../../views/supplier_product/product/add/new/new_add_product_screen.dart';
import 'package:troond/views/chat/ui/chat_screen.dart';

class RoutesGenerate {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      //* auth
      case AppRoutes.loginScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LoginScreen(),
        );
      case AppRoutes.registerScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const RegisterScreen(),
        );
      case AppRoutes.forgetPasswordScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ForgetPawwordScreen(),
        );
      case AppRoutes.confirmPasswordScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ConfirmPasswordScreen(),
        );
      case AppRoutes.changePasswordScreen:
        int userId = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ChangePasswordScreen(userId: userId),
        );

      case AppRoutes.splashScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SplashScreen(),
        );
      case AppRoutes.mainScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainScreen(),
        );

      case AppRoutes.editProfileScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const EditProfileScreen(),
        );
      case AppRoutes.editNumberScreen:
        final int userId = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditNumberScreen(userId: userId),
        );

      case AppRoutes.ordersScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const OrdersScreen(),
        );
      case AppRoutes.orderDetailsScreen:
        OrderModel orderModel = settings.arguments as OrderModel;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              OrderDetailsScreen(orderModel: orderModel),
        );

      case AppRoutes.addressScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AddressScreen(),
        );
      case AppRoutes.addAddressScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AddAddressScreen(),
        );
      case AppRoutes.editAddressScreen:
        AddressModel address = settings.arguments as AddressModel;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditAddressScreen(
            address: address,
          ),
        );

      case AppRoutes.productPreviewScreen:
        final int id = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProductPreviewScreen(id: id),
        );
      case AppRoutes.productsGroupScreen:
        List<ProductPreview> products =
            settings.arguments as List<ProductPreview>;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProductsGroupScreen(products: products),
        );

      case AppRoutes.myListScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MyListsScreen(),
        );
      case AppRoutes.addListScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AddListScreen(),
        );
      case AppRoutes.editListScreen:
        List arg = settings.arguments as List;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditListScreen(arg: arg),
        );

      case AppRoutes.favScreen:
        bool hasBackBtn = settings.arguments as bool;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => FavScreen(hasBackBtn: hasBackBtn),
        );

      case AppRoutes.subCategoryScreen:
        CategoryModel parentCategory =
            settings.arguments as CategoryModel;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              SubCategoryScreen(parentCategory: parentCategory),
        );
      case AppRoutes.viewParentCategory:
        int id = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ViewParnetCategory(id: id),
        );
      case AppRoutes.productsListScreen:
        dynamic args = settings.arguments;
        Future<List<ProductPreview>>? future;
        int? categoryId;
        String? title;

        if (args is Future<List<ProductPreview>>) {
          future = args;
        } else if (args is int) {
          categoryId = args;
        } else if (args is Map) {
          future = args['future'] as Future<List<ProductPreview>>?;
          categoryId = args['categoryId'] as int?;
          title = args['title'] as String?;
        }

        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProductsListScreen(
            future: future,
            categoryId: categoryId,
            title: title,
          ),
        );
      case AppRoutes.productsListScreen2:
        dynamic args = settings.arguments;
        List<ProductPreview> productList = [];
        String? title;
        if (args is List<ProductPreview>) {
          productList = args;
        } else if (args is Map) {
          productList = (args['products'] as List<ProductPreview>?) ?? [];
          title = args['title'] as String?;
        }
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              ProductsListScreen2(productList: productList, title: title),
        );

      case AppRoutes.brandScreen:
        final int id = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => BrandScreen(id: id),
        );

      case AppRoutes.allBrandsScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AllBrandsScreen(),
        );

      case AppRoutes.beSupplier:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const BeSupplierScreen());
      case AppRoutes.bankInfo:
        int id = settings.arguments as int;
        return PageRouteBuilder(pageBuilder: (_, __, ___) => BankInfo(id: id));
      case AppRoutes.companyInfo:
        int id = settings.arguments as int;
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => CompanyInfo(id: id));
      case AppRoutes.doneStep:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => const DoneStep());
      case AppRoutes.verifiyEmail:
        int id = settings.arguments as int;
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => VerfiyEmail(id: id));

      case AppRoutes.filterScreen:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const FilterScreen());
      case AppRoutes.categoryFilterScreen:
        FilterModel filterModel = settings.arguments as FilterModel;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              FilterCategoryScreen(filterModel: filterModel),
        );
      case AppRoutes.filterBrandScreen:
        FilterModel filterModel = settings.arguments as FilterModel;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              FilterBrandScreen(filterModel: filterModel),
        );

      case AppRoutes.filterColorScreen:
        FilterModel filterModel = settings.arguments as FilterModel;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) =>
              FilterColorScreen(filterModel: filterModel),
        );

      case AppRoutes.paymentsScreen:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const PaymentScreen());
      case AppRoutes.paymentProcessingScreen:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const PaymentProcessingScreen());
      case AppRoutes.recentPaymentScreen:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const RecentPaymentScreen());
      case AppRoutes.checkoutScreen:
        List<ProductCart> yourCart = settings.arguments as List<ProductCart>;
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => CheckoutScreen(yourCart: yourCart),
        );
      case AppRoutes.checkoutDoneScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const CheckoutOrderScreen(),
        );
      case AppRoutes.changeAddressScreen:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const ChangeAddressScreen());

      case AppRoutes.reviewScreen:
        OrderModel orderModel = settings.arguments as OrderModel;
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => ReviewScreen(orderModel: orderModel));
      case AppRoutes.reviewProductScreen:
        OrderModelItem orderItem = settings.arguments as OrderModelItem;
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) =>
                ReviewProductScreen(orderItem: orderItem));

      case AppRoutes.cartScreen:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const CartScreen(hasLeading: true));

      case AppRoutes.helpScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HelpScreen(),
        );

      case AppRoutes.chatScreen:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const ChatScreen(),
        );

      case AppRoutes.supplierProductScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SupplierProductScreen(),
        );
      case AppRoutes.addProductScreen:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AddProductScreen(),
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainScreen(),
        );

      //
    }
  }
}
