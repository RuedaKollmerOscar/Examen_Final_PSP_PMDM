import 'package:flutter/material.dart';
import 'package:techshop/Main/HomeView.dart';
import 'package:techshop/Theme/DarkMode.dart';

import 'Main/AccountView.dart';
import 'Main/ComponenteView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';
import 'Splash/SplashView.dart';
import 'Theme/LightMode.dart';

class TechShopApp extends StatelessWidget {
  const TechShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TechShop",
      debugShowCheckedModeBanner: false,
      theme: LightMode,
      darkTheme: DarkMode,
      routes: {
        "/loginview": (context) => LoginView(),
        "/registerview": (context) => RegisterView(),
        "/homeview": (context) => HomeView(),
        "/splashview": (context) => SplashView(),
        "/accountview": (context) => AccountView(),
        "/componenteview": (context) => ComponenteView()
      },
      initialRoute: "/splashview"
    );
  }
}
