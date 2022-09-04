import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getThemeDataLight()=>ThemeData(
   fontFamily: 'Janna',
   primarySwatch: Colors.indigo,
   scaffoldBackgroundColor: Colors.white,
   appBarTheme: const AppBarTheme(
     systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
     ),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 24.0,
        fontWeight: FontWeight.w900,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 28.0,
      ),
      titleSpacing: 20.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
   ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    elevation: 1.0,
    unselectedItemColor: Colors.black45,
    selectedItemColor: Colors.indigo,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      color: Colors.black,
    ),
    headline5: TextStyle(
      fontSize: 22.0,
      color: Colors.black,
    )
  ),
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5