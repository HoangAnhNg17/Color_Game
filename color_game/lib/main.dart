import 'package:color_game/bloc/theme.dart';
import 'package:color_game/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    theme: darkAppThemeData,
    darkTheme: appThemeData,
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    getPages: [
      GetPage(name: "/", page: ()=> SplashPage()),
    ],
  ));
}