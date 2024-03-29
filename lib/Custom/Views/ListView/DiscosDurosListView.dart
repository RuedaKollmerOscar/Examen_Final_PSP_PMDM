import 'package:flutter/material.dart';

class DiscosDurosListView extends StatelessWidget {
  final String sNombre;
  final String sTipo;
  final int iEscritura;
  final int iLectura;
  final double dPrecio;
  final int iAlmacenamiento;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  const DiscosDurosListView({super.key,
    required this.sNombre,
    required this.sTipo,
    required this.iEscritura,
    required this.iLectura,
    required this.dPrecio,
    required this.iAlmacenamiento,
    required this.sUrlImg,
    required this.iPosicion,
    this.fOnItemTap,
  });

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
              textAlign: TextAlign.center,
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
              'Tipo: $sTipo',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            Text(
              'Almacenamiento: $iAlmacenamiento GB',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            Text(
              'Velocidad de lectura: $iLectura MB/s',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            Text(
              'Velocidad de escritura: $iEscritura MB/s',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            Text(
              'Precio: $dPrecio €',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
