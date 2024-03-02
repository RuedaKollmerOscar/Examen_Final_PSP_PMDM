import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Singletone/DataHolder.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  late String loadingText;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    loadingText = 'Conectando con los dioses';
    startTimer();
    checkSession();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) {
      setState(() {
        loadingText = 'Conectando con los dioses${'.' * ((t.tick % 3) + 1)}';
      });
    });
  }

  void checkSession() async {
    await Future.delayed(const Duration(seconds: 4));
    timer.cancel();
    if (DataHolder().fbadmin.getCurrentUserID() != null) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else {
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitThreeBounce(
              color: Theme.of(context).colorScheme.primary,
              size: 25.0,
            ),
            const SizedBox(height: 20),
            Text(
              loadingText,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
