import 'package:flutter/material.dart';

class FuentesListView extends StatelessWidget {
  final String sNombre;
  final String sTipoCableado;
  final String sFormato;
  final int iPotencia;
  final String sCertificacion;
  final String sUrlImg;
  final double dPrecio;
  final int iPosicion;
  final Function(int indice)? fOnItemTap;

  const FuentesListView({
    Key? key,
    required this.sNombre,
    required this.sTipoCableado,
    required this.sFormato,
    required this.iPotencia,
    required this.sCertificacion,
    required this.sUrlImg,
    required this.dPrecio,
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
              'Tipo de Cableado: $sTipoCableado',
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Formato: $sFormato',
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Potencia: ${iPotencia.toStringAsFixed(0)}W',
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Certificación: $sCertificacion',
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
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
