import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'TechShopApp.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Evitar la rotación de la pantalla a horizontal
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  TechShopApp techShopApp = const TechShopApp();
  runApp(techShopApp);
}