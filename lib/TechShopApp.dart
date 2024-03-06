import 'package:flutter/material.dart';
import 'package:techshop/Main/CatalogoView.dart';
import 'package:techshop/Main/CategoriasView.dart';
import 'package:techshop/Main/HomeView.dart';
import 'package:techshop/Main/MapaTiendasView.dart';
import 'package:techshop/Main/SubirProductosView.dart';
import 'package:techshop/Main/SobreNosotrosView.dart';
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
        "/componenteview": (context) => ComponenteView(),
        "/mapatiendasview": (context) => MapaTiendasView(),
        "/sobrenosotrosview": (context) => SobreNosotrosView(),
        "/categoriasview": (context) => CategoriasView(),
        "/catalogoview": (context) => CatalogoView(),
        "/subirproductosview": (context) => SubirProductosView()
      },
      initialRoute: "/splashview"
    );
  }
}
