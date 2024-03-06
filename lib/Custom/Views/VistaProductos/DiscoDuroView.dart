import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbDiscoDuro.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class DiscoDuroView extends StatelessWidget {
  const DiscoDuroView({super.key});

  @override
  Widget build(BuildContext context) {
    FbDiscoDuro discoDuroSeleccionado = DataHolder().discoDuroSeleccionado;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: discoDuroSeleccionado.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${discoDuroSeleccionado.sNombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Tipo: ${discoDuroSeleccionado.sTipo}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Velocidad de Escritura: ${discoDuroSeleccionado.iEscritura} MB/s',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Velocidad de Lectura: ${discoDuroSeleccionado.iLectura} MB/s',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Almacenamiento: ${discoDuroSeleccionado.iAlmacenamiento}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: ${discoDuroSeleccionado.dPrecio} €',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              if (discoDuroSeleccionado.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    discoDuroSeleccionado.sUrlImg,
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