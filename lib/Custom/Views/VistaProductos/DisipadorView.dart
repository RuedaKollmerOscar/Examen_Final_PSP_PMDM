import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbDisipador.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class DisipadorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FbDisipador disipadorSeleccionado = DataHolder().disipadorSeleccionado;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: disipadorSeleccionado.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${disipadorSeleccionado.sNombre}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Color: ${disipadorSeleccionado.sColor}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Material: ${disipadorSeleccionado.sMaterial}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Velocidad Mínima: ${disipadorSeleccionado.iVelocidadRotacionMinima} RPM',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Velocidad Máxima: ${disipadorSeleccionado.iVelocidadRotacionMaxima} RPM',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Precio: ${disipadorSeleccionado.dPrecio} €',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              if (disipadorSeleccionado.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    disipadorSeleccionado.sUrlImg,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}