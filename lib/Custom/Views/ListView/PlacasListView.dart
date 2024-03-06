import 'package:flutter/material.dart';

class PlacasListView extends StatelessWidget {
  final String sNombre;
  final String sFactorForma;
  final String sSocket;
  final String sChipset;
  final bool bWifi;
  final double dPrecio;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  const PlacasListView({
    Key? key,
    required this.sNombre,
    required this.sFactorForma,
    required this.sSocket,
    required this.sChipset,
    required this.bWifi,
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
              'Factor de Forma: $sFactorForma',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Socket: $sSocket',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Chipset: $sChipset',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Wi-Fi: ${bWifi ? 'Sí' : 'No'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Precio: ${dPrecio.toString()} €',
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