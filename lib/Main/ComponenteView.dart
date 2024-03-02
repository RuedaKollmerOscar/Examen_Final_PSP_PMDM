import 'package:flutter/material.dart';

import '../Singletone/DataHolder.dart';

class ComponenteView extends StatelessWidget {
  ComponenteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DataHolder().componenteSeleccionado.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Cuerpo del post
            Text(
              '${DataHolder().componenteSeleccionado.price.toString()} €',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
