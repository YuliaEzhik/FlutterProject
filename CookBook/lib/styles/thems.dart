import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


const defaultLightColor = Colors.yellowAccent;
const defaultDarkColor = Color(0xFF8B47BB);
const defaultWidgetColor = Colors.purpleAccent;
const darkmodeColor = Color(0xFF121212);

class Themes {
  static final MaterialColor defaultLightMaterialColor = MaterialColor(
    defaultLightColor.value,
    <int, Color>{
      50: defaultLightColor.withOpacity(0.1),
      100: defaultLightColor.withOpacity(0.2),
      200: defaultLightColor.withOpacity(0.3),
      300: defaultLightColor.withOpacity(0.4),
      400: defaultLightColor.withOpacity(0.5),
      500: defaultLightColor.withOpacity(0.6),
      600: defaultLightColor.withOpacity(0.7),
      700: defaultLightColor.withOpacity(0.8),
      800: defaultLightColor.withOpacity(0.9),
      900: defaultLightColor.withOpacity(1),
    },
  );
  static ThemeData darkThem = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkmodeColor,
    primaryColor: defaultDarkColor,
    primarySwatch: defaultLightMaterialColor,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: darkmodeColor,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: darkmodeColor,
          statusBarIconBrightness: Brightness.light,
        )),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: defaultDarkColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkmodeColor.withOpacity(0.8),
        selectedItemColor: defaultDarkColor,
        unselectedItemColor: Colors.grey.withOpacity(0.6)),

    textTheme: TextTheme(
      bodyText1: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyText2: TextStyle(
        color: Colors.white,
      ),
      headline5:
      TextStyle(color: defaultDarkColor, fontWeight: FontWeight.bold),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: defaultLightColor,
    primarySwatch: defaultLightMaterialColor,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(elevation: 10),
    floatingActionButtonTheme:
    FloatingActionButtonThemeData(backgroundColor: defaultLightColor),

    //NOTE : set default bodytext1
    textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        bodyText2: TextStyle(
          color: Colors.black,
        ),
        subtitle1: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        headline5:
        TextStyle(color: defaultLightColor, fontWeight: FontWeight.bold)),
  );
}