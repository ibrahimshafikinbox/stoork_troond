import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_theme.dart';
import 'package:troond/config/routes/app_routes.dart';
import 'package:troond/config/routes/routes_generate.dart';
import 'package:troond/config/setting/app_setting.dart';
import 'package:troond/l10n/app_localizations.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';
import 'package:troond/views/address/controller/address_controller.dart';
import 'package:troond/views/auth/controller/auth_controller.dart';
import 'package:troond/views/auth/controller/passowrd_controller.dart';
import 'package:troond/views/be_supplier/controller/be_supplier_controller.dart';
import 'package:troond/views/cart/controller/cart_controller.dart';
import 'package:troond/views/fav/controller/fav_controller.dart';
import 'package:troond/views/filter/controller/filter_controller.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/views/my_list/controller/my_list_controller.dart';
import 'package:troond/views/product/controller/product_controller.dart';
import 'package:troond/views/profile/controller/profile_controller.dart';
import 'package:troond/views/supplier_product/controller/supplier_product_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainController()),
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => PasswordController()),
        ChangeNotifierProvider(create: (context) => AddressController()),
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => MyListController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => FavController()),
        ChangeNotifierProvider(create: (context) => FilterController()),
        ChangeNotifierProvider(create: (context) => BeSupplierController()),
        ChangeNotifierProvider(create: (context) => SupplierProductController()),
      ],
      builder: (context, child) {
        Provider.of<MainController>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppSetting.appName,
          initialRoute: AppRoutes.splashScreen,
          onGenerateRoute: RoutesGenerate.generate,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: Locale(SharedPref.getLanguage()),
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          theme: AppTheme().getTheme(),
        );
      },
    );
  }
}
