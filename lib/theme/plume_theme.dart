import 'package:flutter/material.dart';

import 'plume_colors.dart';

class PlumeTheme {
  static ThemeData get dartTheme {
    return ThemeData(
      // colorScheme: const ColorScheme(
      //   brightness: Brightness.light,
      //   primary: PlumeColors.background,
      //   onPrimary: PlumeColors.background,
      //   background: PlumeColors.background,
      //   onBackground: PlumeColors.background,
      //   surface: PlumeColors.primary,
      //   onSurface: PlumeColors.primary,
      //   secondary: PlumeColors.primary,
      //   onSecondary: PlumeColors.primary,
      //   error: PlumeColors.primary,
      //   onError: PlumeColors.primary,
      // ),
      primaryColor: PlumeColors.primary,
      scaffoldBackgroundColor: PlumeColors.scaffoldBackgroundColor,
      fontFamily: 'CatamaranRegular',
      textSelectionTheme: const TextSelectionThemeData(cursorColor: PlumeColors.primary),
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          color: PlumeColors.bodyText1,
        ),
        bodyText2: TextStyle(
          color: PlumeColors.bodyText2,
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: PlumeColors.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(PlumeColors.primary),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackColor: MaterialStateProperty.all<Color>(PlumeColors.primary),
        thumbColor: MaterialStateProperty.all<Color>(PlumeColors.background)
        // overlayColor:  MaterialStateProperty.all<Color>(PlumeColors.primary)
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PlumeColors.primary
          )
        ),
        labelStyle: TextStyle(color: PlumeColors.primary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: PlumeColors.primary,
      )
    );
  }
}
