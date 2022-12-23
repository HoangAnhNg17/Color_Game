import 'package:get/get.dart';
import 'package:flutter/material.dart';


class ThemeGet extends GetxController{
  static final ThemeGet _theme = ThemeGet._internal();
  factory ThemeGet() => _theme;
  ThemeGet._internal();

  RxBool isDarkMode = true.obs;
  RxDouble shape = 10.00.obs;
  RxList listCheckBox = [true, false, false].obs;

  void handleList(int index){
    for(int i = 0; i < listCheckBox.value.length; i++) {
      if(i == index) {
        listCheckBox.value[i] = true;
      }else{
        listCheckBox.value[i] = false;
      }
    }
  }

  void changeMode(){
    isDarkMode.value = !isDarkMode.value;
  }


}

final theme = ThemeGet();

final ThemeData appThemeData = ThemeData(
  primaryColor: Color(0xFF6BC6FF),
  fontFamily: 'PressStart2P',
);

final ThemeData darkAppThemeData = ThemeData(
// primaryColor: Colors.red,
  primaryColor: Color(0xFF120023),
  fontFamily: 'PressStart2P',
);