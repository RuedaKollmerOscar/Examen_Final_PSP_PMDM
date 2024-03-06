import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbCaja.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart'; // Asegúrate de importar el archivo correcto

class CajaView extends StatelessWidget {
  const CajaView({super.key});

  @override
  Widget build(BuildContext context) {
    FbCaja cajaSeleccionada = DataHolder().cajaSeleccionada;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: cajaSeleccionada.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${cajaSeleccionada.sNombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Ajusta el tamaño del texto
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Color: ${cajaSeleccionada.sColor}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Peso: ${cajaSeleccionada.dPeso} kg',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: ${cajaSeleccionada.dPrecio} €',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20),
              if (cajaSeleccionada.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cajaSeleccionada.sUrlImg,
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