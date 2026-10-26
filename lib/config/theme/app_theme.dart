import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:troond/config/strings/app_string.dart';
import 'package:troond/config/theme/app_color.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      fontFamily: AppStrings.font,
      scaffoldBackgroundColor: AppColor.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: AppColor.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColor.c121212,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(color: AppColor.c121212),
      ),
      cardTheme: const CardThemeData(elevation: 0),
      iconTheme: const IconThemeData(color: AppColor.white),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(backgroundColor: AppColor.white),
      ),
      //* input
      inputDecorationTheme: InputDecorationTheme(
        hoverColor: AppColor.white,
        contentPadding: EdgeInsets.zero,
        hintStyle: const TextStyle(
          color: AppColor.cDADCE3,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        fillColor: AppColor.white,
        labelStyle: const TextStyle(color: AppColor.c414141),
        enabledBorder: getBorder(AppColor.white),
        border: getBorder(AppColor.cDBDBDB),
        focusedBorder: getBorder(AppColor.cDBDBDB),
        errorBorder: getBorder(AppColor.cD21318),
        helperStyle: const TextStyle(color: AppColor.c121212),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColor.main,
        selectedLabelStyle: TextStyle(color: AppColor.main),
        unselectedItemColor: AppColor.c7E859B,
        unselectedLabelStyle: TextStyle(color: AppColor.c7E859B),
      ),
      checkboxTheme: const CheckboxThemeData(
        side: BorderSide(color: AppColor.cB8B8B8),
      ),
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColor.c717171,
        indicatorColor: AppColor.main,
        unselectedLabelStyle: TextStyle(fontSize: 20),
        labelStyle: TextStyle(
          color: AppColor.main,
          fontSize: 20,
        ),
      ),
    );
  }

  getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: color,
        width: 0.5,
      ),
    );
  }
}
