import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/categories/ui/categories_screen.dart';
import 'package:troond/views/fav/ui/fav_screen.dart';
import 'package:troond/views/home/ui/home_screen.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/views/profile/ui/profile_screen/profile_screen.dart';
import 'package:troond/widget/nav_bar/custom_bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    // const CartScreen(hasLeading: false),
    const FavScreen(hasBackBtn: false),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var mainController = Provider.of<MainController>(context);
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(),
      body: screens.elementAt(mainController.index),
    );
  }
}
