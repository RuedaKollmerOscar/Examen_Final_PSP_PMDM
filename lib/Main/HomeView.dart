import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomDrawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
  }
}