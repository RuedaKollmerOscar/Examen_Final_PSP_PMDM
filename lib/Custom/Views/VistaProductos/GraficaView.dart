import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbGrafica.dart'; // Asegúrate de importar el archivo correcto
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class GraficaView extends StatelessWidget {
  const GraficaView({super.key});

  @override
  Widget build(BuildContext context) {
    FbGrafica graficaSeleccionada = DataHolder().graficaSeleccionada;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: graficaSeleccionada.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${graficaSeleccionada.sNombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Ensamblador: ${graficaSeleccionada.sEnsamblador}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Fabricante: ${graficaSeleccionada.sFabricante}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Serie: ${graficaSeleccionada.sSerie}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Capacidad: ${graficaSeleccionada.iCapacidad} GB',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Generación: ${graficaSeleccionada.iGeneracion}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: ${graficaSeleccionada.dPrecio} €',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (graficaSeleccionada.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    graficaSeleccionada.sUrlImg,
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