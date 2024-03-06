import 'package:flutter/material.dart';

class DisipadoresListView extends StatelessWidget {
  final String sNombre;
  final String sColor;
  final String sMaterial;
  final int iVelocidadRotacionMinima;
  final int iVelocidadRotacionMaxima;
  final double dPrecio;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  const DisipadoresListView({
    Key? key,
    required this.sNombre,
    required this.sColor,
    required this.sMaterial,
    required this.iVelocidadRotacionMinima,
    required this.iVelocidadRotacionMaxima,
    required this.dPrecio,
    required this.sUrlImg,
    required this.iPosicion,
    this.fOnItemTap,
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
              'Color: $sColor',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Material: $sMaterial',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Velocidad mínima: ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$iVelocidadRotacionMinima RPM',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Velocidad máxima: ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$iVelocidadRotacionMaxima RPM',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Text(
              'Precio: $dPrecio €',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}