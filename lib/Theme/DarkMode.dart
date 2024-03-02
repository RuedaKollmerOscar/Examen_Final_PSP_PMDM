import 'package:flutter/material.dart';

ThemeData DarkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.purple.shade900,
        secondary: Colors.purple.shade800,
        inversePrimary: Colors.purple.shade300
    ),
    textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.grey[300],
        displayColor: Colors.white
    )
);