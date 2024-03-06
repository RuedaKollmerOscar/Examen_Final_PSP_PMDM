import 'package:flutter/material.dart';

class ProcesadoresListView extends StatelessWidget {
  final String sNombre;
  final String sMarca;
  final String sModelo;
  final int iNucleos;
  final int iHilos;
  final double dVelocidadBase;
  final bool bOverclock;
  final double dPrecio;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  ProcesadoresListView({
    Key? key,
    required this.sNombre,
    required this.sMarca,
    required this.sModelo,
    required this.iNucleos,
    required this.iHilos,
    required this.dVelocidadBase,
    required this.bOverclock,
    required this.dPrecio,
    required this.sUrlImg,
    required this.iPosicion,
    required this.fOnItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fOnItemTap!(iPosicion),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              sNombre,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                sUrlImg,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Marca: $sMarca',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Modelo: $sModelo',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Núcleos: $iNucleos',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Hilos: $iHilos',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Velocidad Base: ${dVelocidadBase.toString()} GHz',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Overclock: ${bOverclock ? 'Sí' : 'No'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Precio: ${dPrecio.toString()} €',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}