import 'package:flutter/material.dart';

class RAMsListView extends StatelessWidget {
  final String sNombre;
  final int iCapacidad;
  final int iModulos;
  final int iVelocidad;
  final int iGeneracion;
  final bool bRGB;
  final double dPrecio;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  RAMsListView({
    Key? key,
    required this.sNombre,
    required this.iCapacidad,
    required this.iModulos,
    required this.iVelocidad,
    required this.iGeneracion,
    required this.bRGB,
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
              'Capacidad: $iCapacidad GB',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Módulos: x$iModulos',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Velocidad: $iVelocidad MHz',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Generación: DDR$iGeneracion',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'RGB: ${bRGB ? 'Sí' : 'No'}',
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
