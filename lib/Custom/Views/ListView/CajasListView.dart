import 'package:flutter/material.dart';

class CajasListView extends StatelessWidget {
  final String sName;
  final String sColor;
  final double dPeso;
  final double dPrecio;
  final String sUrlImg;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  const CajasListView({
    Key? key,
    required this.sName,
    required this.sColor,
    required this.dPeso,
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
              sName,
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
              'Peso: $dPeso kg',
              style: TextStyle(
                fontSize: 16,
              ),
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
