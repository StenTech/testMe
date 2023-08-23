import 'package:flutter/material.dart';
import './app_color.dart';

final testmeAppThemeData = ThemeData(
  // Primary color of our gueze app
  primaryColor: AppColor.primaryColor,

  //colorScheme of our gueze app
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: AppColor.primaryColor,
  //   background: AppColor.primaryBackgroundColor,
  //   //secondary: const Color(0x0002347A),
  // ),
  colorScheme: const ColorScheme(
    primary: AppColor.primaryColor,
    secondary: AppColor.secondaryColor,
    surface: AppColor.buttonBackgroundColor,
    background: AppColor.primaryBackgroundColor,
    error: AppColor.errorColor,
    onPrimary: AppColor.onPrimaryColor,
    onSecondary: AppColor.onSecondaryColor,
    onSurface: AppColor.tertiaryTextColor,
    onBackground: AppColor.primaryTextColor,
    onError: AppColor.onErrorColor,
    brightness: Brightness.light,
  ),

  // the font family : openSans
  fontFamily: 'OpenSans',

  // global icon theme
  iconTheme: const IconThemeData(
    color: Color(0x0002347A),
  ),

  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(AppColor.iconButtonBackgroundColor),
      iconColor: MaterialStateProperty.all<Color>(AppColor.iconButtonColor),
    ),
  ),

  searchBarTheme: SearchBarThemeData(
    backgroundColor:
        MaterialStateProperty.all(AppColor.searchBarBackgroundColor),
    hintStyle: MaterialStateProperty.all(
        TextStyle(color: AppColor.searchBarHintTextColor)),
    textStyle: MaterialStateProperty.all(
        TextStyle(color: AppColor.searchBarTextColor)),
  ),
  // global text theme
  // textTheme: const TextTheme(

  // ),
);
