import 'package:flutter/material.dart';

ThemeData LightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.purple.shade200,
        secondary: Colors.purple.shade400,
        inversePrimary: Colors.purple.shade800
    ),
    textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.black
    )
);