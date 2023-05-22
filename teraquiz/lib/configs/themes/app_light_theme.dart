import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teraquiz/configs/themes/sub_theme_data_mixing.dart';

const Color primaryLightColorLight= Color(0xFF3ac3cb);
const Color primaryColorLight= Color(0xFFf85187);
const Color mainTextColorLight= Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData{
  buildLightTheme(){
   final ThemeData systemLightTheme = ThemeData.light();
   return systemLightTheme.copyWith(
     cardColor: cardColor,
     primaryColor: primaryColorLight,
     iconTheme: getIconTheme(),
     textTheme: getTextThemes().apply(
       bodyColor:mainTextColorLight,
       displayColor: mainTextColorLight
     )
   );
  }
}