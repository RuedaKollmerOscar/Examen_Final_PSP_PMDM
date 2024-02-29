import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';

class TechShopApp extends StatelessWidget {
  const TechShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TechShop",
      debugShowCheckedModeBanner: false,
      routes: {
        '/loginview': (context) => LoginView(),
        '/registerview': (context) => RegisterView(),
      },
      initialRoute: '/loginview'
    );
  }
}
