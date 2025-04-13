import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static ThemeData get lightTheme => ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );

  static Color primaryColor = Colors.blue;
  static Color secondaryColor = Colors.green;

  static TextStyle get bodyText1 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      );

  static TextStyle get bodyText2 => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.grey,
      );
}
