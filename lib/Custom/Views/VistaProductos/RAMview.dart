import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbRAM.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class RAMView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FbRAM ramSeleccionada = DataHolder().ramSeleccionada;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: ramSeleccionada.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${ramSeleccionada.sNombre}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Capacidad: ${ramSeleccionada.iCapacidad} GB',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Cantidad de Módulos: ${ramSeleccionada.iModulos}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Velocidad: ${ramSeleccionada.iVelocidad} MHz',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Generación: ${ramSeleccionada.iGeneracion}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'RGB: ${ramSeleccionada.bRGB ? 'Sí' : 'No'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Precio: ${ramSeleccionada.dPrecio} €',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              if (ramSeleccionada.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    ramSeleccionada.sUrlImg,
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