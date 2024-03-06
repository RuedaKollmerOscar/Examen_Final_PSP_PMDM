import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbProcesador.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class ProcesadorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FbProcesador procesadorSeleccionado = DataHolder().procesadorSeleccionado;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: procesadorSeleccionado.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${procesadorSeleccionado.sNombre}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Marca: ${procesadorSeleccionado.sMarca}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Modelo: ${procesadorSeleccionado.sModelo}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Núcleos: ${procesadorSeleccionado.iNucleos}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Hilos: ${procesadorSeleccionado.iHilos}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Velocidad Base: ${procesadorSeleccionado.dVelocidadBase} GHz',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Overclock: ${procesadorSeleccionado.bOverclock ? 'Sí' : 'No'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Precio: ${procesadorSeleccionado.dPrecio} €',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              if (procesadorSeleccionado.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    procesadorSeleccionado.sUrlImg,
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