import 'package:flutter/material.dart';
import 'package:techshop/FirestoreObjects/FbFuente.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class FuenteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FbFuente fuenteSeleccionada = DataHolder().fuenteSeleccionada;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: fuenteSeleccionada.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${fuenteSeleccionada.sNombre}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tipo de Cableado: ${fuenteSeleccionada.sTipoCableado}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Formato: ${fuenteSeleccionada.sFormato}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Potencia: ${fuenteSeleccionada.iPotencia} W',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Certificación: ${fuenteSeleccionada.sCertificacion}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Precio: ${fuenteSeleccionada.dPrecio} €',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              if (fuenteSeleccionada.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    fuenteSeleccionada.sUrlImg,
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