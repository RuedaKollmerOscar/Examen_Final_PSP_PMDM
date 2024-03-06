import 'package:flutter/material.dart';
import 'package:techshop/Custom/Views/VistaProductos/FuenteView.dart';
import 'package:techshop/Custom/Views/VistaProductos/PlacaView.dart';

import 'Custom/Views/VistaProductos/CajaView.dart';
import 'Custom/Views/VistaProductos/DiscoDuroView.dart';
import 'Custom/Views/VistaProductos/DisipadorView.dart';
import 'Main/AccountView.dart';
import 'Main/CatalogoView.dart';
import 'Main/CategoriasView.dart';
import 'Main/ComponenteView.dart';
import 'Main/HomeView.dart';
import 'Main/MapaTiendasView.dart';
import 'Main/SobreNosotrosView.dart';
import 'Main/SubirProductosView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';
import 'Splash/SplashView.dart';
import 'Theme/DarkMode.dart';
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
        // Autentificacion
        "/loginview": (context) => LoginView(),
        "/registerview": (context) => RegisterView(),
        "/splashview": (context) => SplashView(),

        // Vistas de productos
        "/cajaview": (context) => CajaView(),
        "/discoduroview": (context) => DiscoDuroView(),
        "/disipadorview": (context) => DisipadorView(),
        "/fuenteview": (context) => FuenteView(),
        "/placaview": (context) => PlacaView(),

        "/homeview": (context) => HomeView(),
        "/accountview": (context) => AccountView(),
        "/componenteview": (context) => ComponenteView(),
        "/mapatiendasview": (context) => MapaTiendasView(),
        "/sobrenosotrosview": (context) => SobreNosotrosView(),
        "/categoriasview": (context) => CategoriasView(),
        "/catalogoview": (context) => CatalogoView(),
        "/subirproductosview": (context) => SubirProductosView(),
      },
      initialRoute: "/splashview"
    );
  }
}
