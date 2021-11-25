import 'package:flutter/material.dart';

class AppTheme{
  static final AppTheme _singleton = AppTheme._internal();
  AppTheme._internal();
  factory AppTheme() {
    return _singleton;
  }
  
  Color primaryColor =  Colors.white;
  Color assetColor = const Color(0xFF7A8C9D);
  Color backgroundColor = const Color(0xFFF5FAFD);
  Color red =  Colors.red;
  Color green = Colors.green;
  Color yellow = Colors.orange;
  Color textColor = const Color(0xFF486A7E);

  TextStyle?  title(BuildContext context) => Theme.of(context).textTheme.headline6?.copyWith(color: textColor);
  TextStyle?  subTitle(BuildContext context) => Theme.of(context).textTheme.subtitle1?.copyWith(color: textColor);
  TextStyle?  body1(BuildContext context) => Theme.of(context).textTheme.bodyText1?.copyWith(color: textColor);
  TextStyle?  body2(BuildContext context) => Theme.of(context).textTheme.bodyText2?.copyWith(color: textColor);
  TextStyle?  caption(BuildContext context) => Theme.of(context).textTheme.caption?.copyWith(color: textColor);

  ThemeData getLightTheme(BuildContext context) => ThemeData(
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
      titleTextStyle: title(context),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: assetColor),
    scaffoldBackgroundColor: backgroundColor,
    brightness: Brightness.light,
  );
}