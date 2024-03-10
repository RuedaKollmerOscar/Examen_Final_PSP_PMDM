import 'package:flutter/material.dart';
import 'package:techshop/Custom/Views/VistaProductos/FuenteView.dart';
import 'package:techshop/Custom/Views/VistaProductos/PlacaView.dart';
import 'package:techshop/Custom/Views/VistaProductos/RAMview.dart';

import 'Custom/Views/VistaProductos/CajaView.dart';
import 'Custom/Views/VistaProductos/DiscoDuroView.dart';
import 'Custom/Views/VistaProductos/DisipadorView.dart';
import 'Custom/Views/VistaProductos/GraficaView.dart';
import 'Custom/Views/VistaProductos/ProcesadorView.dart';
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
        "/loginview": (context) => const LoginView(),
        "/registerview": (context) => const RegisterView(),
        "/splashview": (context) => const SplashView(),

        // Vistas de productos
        "/cajaview": (context) => CajaView(),
        "/discoduroview": (context) => DiscoDuroView(),
        "/disipadorview": (context) => DisipadorView(),
        "/fuenteview": (context) => FuenteView(),
        "/placaview": (context) => PlacaView(),
        "/procesadorview": (context) => ProcesadorView(),
        "/ramview": (context) => RAMView(),
        "/graficaview": (context) => GraficaView(),

        "/homeview": (context) => const HomeView(),
        "/accountview": (context) => const AccountView(),
        "/componenteview": (context) => const ComponenteView(),
        "/mapatiendasview": (context) => const MapaTiendasView(),
        "/sobrenosotrosview": (context) => const SobreNosotrosView(),
        "/categoriasview": (context) => const CategoriasView(),
        "/catalogoview": (context) => const CatalogoView(),
        "/subirproductosview": (context) => const SubirProductosView(),
      },
      initialRoute: "/splashview"
    );
  }
}
