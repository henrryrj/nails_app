import 'package:flutter/material.dart';

import 'colors/MyColors.dart';

class PrimaryTheme {
  static ThemeData get lightTheme { //1
    return ThemeData( //2
        primaryColor: MyColors.PrimaryColor,
        accentColor: MyColors.AccentColor,
        primaryColorDark: MyColors.DarkPrimaryColor,
        backgroundColor: Colors.white,
        primaryColorLight: MyColors.LightPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
        primaryTextTheme: Typography.whiteRedwoodCity,
        textTheme: Typography.blackRedwoodCity,
        buttonTheme: ButtonThemeData( // 4
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          buttonColor: MyColors.LightPrimaryColor,
        )
    );
  }
}