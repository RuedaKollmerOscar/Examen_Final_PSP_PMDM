import 'package:flutter/material.dart';

class GraficasListView extends StatelessWidget {
  final String sNombre;
  final String sEnsamblador;
  final String sFabricante;
  final String sSerie;
  final int iCapacidad;
  final String sGeneracion;
  final double dPrecio;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  GraficasListView({
    Key? key,
    required this.sNombre,
    required this.sEnsamblador,
    required this.sFabricante,
    required this.sSerie,
    required this.iCapacidad,
    required this.sGeneracion,
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
              'Ensamblador: $sEnsamblador',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Fabricante: $sFabricante',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Serie: $sSerie',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Capacidad: $iCapacidad GB',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Generación: GDDR$sGeneracion',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Precio: ${dPrecio.toString()}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
