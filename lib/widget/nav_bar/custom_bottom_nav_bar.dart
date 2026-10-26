import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/app_local/app_local.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/widget/images/svg_widget.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var mainController = Provider.of<MainController>(context);
    var local = MyLocalizations.getLocal(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: AppColor.main,
          unselectedItemColor: Colors.grey.shade600,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgWidget(
                  svgName: mainController.index == 0
                      ? "botton_nav/home1.svg"
                      : "botton_nav/home0.svg",
                ),
              ),
              label: local.home,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgWidget(
                  svgName: mainController.index == 1
                      ? "botton_nav/category1.svg"
                      : "botton_nav/category0.svg",
                ),
              ),
              label: local.categories,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgWidget(
                  svgName: mainController.index == 2
                      ? "botton_nav/heart1.svg"
                      : "botton_nav/heart0.svg",
                ),
              ),
              label: local.favorite,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(6.0),
                child: SvgWidget(
                  svgName: mainController.index == 3
                      ? "botton_nav/user1.svg"
                      : "botton_nav/user0.svg",
                ),
              ),
              label: local.profile,
            ),
          ],
          currentIndex: mainController.index,
          onTap: (value) {
            mainController.changeIndex(value, context);
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
          },
        ),
      ),
    );
  }
}
