import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/core/global/themes/app_color/app_color_dark.dart';

ThemeData getThemeDataDark() => ThemeData(
      fontFamily: 'Janna',
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: AppColorDark.mainDarkColor,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColorDark.mainDarkColor,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 30.0,
        ),
        titleSpacing: 20.0,
        backgroundColor: AppColorDark.mainDarkColor,
        elevation: 0.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        elevation: 20.0,
        backgroundColor: AppColorDark.mainDarkColor,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigo,
      ),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
        ),
        subtitle1: TextStyle(
          color: Colors.white,
        ),
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
