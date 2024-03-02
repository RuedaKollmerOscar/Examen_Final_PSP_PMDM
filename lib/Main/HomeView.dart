import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomDrawer.dart';
import '../OnBoarding/LoginView.dart';
import '../Singletone/DataHolder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "H O M E",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: CustomDrawer(fOnItemTap: onDrawerPressed),
    );
  }

  void onDrawerPressed(int indice) async {
    if (indice == 4) {
    DataHolder().fbadmin.cerrarSesion();
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
    ModalRoute.withName("/loginview"));
    }
  }
}