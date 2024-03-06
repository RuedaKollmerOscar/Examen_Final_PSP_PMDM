import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbProcesador.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class ProcesadorView extends StatelessWidget {
  const ProcesadorView({super.key});

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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Marca: ${procesadorSeleccionado.sMarca}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Modelo: ${procesadorSeleccionado.sModelo}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Núcleos: ${procesadorSeleccionado.iNucleos}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Hilos: ${procesadorSeleccionado.iHilos}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Velocidad Base: ${procesadorSeleccionado.dVelocidadBase} GHz',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Overclock: ${procesadorSeleccionado.bOverclock ? 'Sí' : 'No'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: ${procesadorSeleccionado.dPrecio} €',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
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