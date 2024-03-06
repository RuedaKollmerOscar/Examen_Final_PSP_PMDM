import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbPlaca.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';

class PlacaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FbPlaca placaSeleccionada = DataHolder().placaSeleccionada;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: placaSeleccionada.sNombre),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${placaSeleccionada.sNombre}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Factor de Forma: ${placaSeleccionada.sFactorForma}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Socket: ${placaSeleccionada.sSocket}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Chipset: ${placaSeleccionada.sChipset}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Wifi: ${placaSeleccionada.bWifi ? 'Sí' : 'No'}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Precio: ${placaSeleccionada.dPrecio} €',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              if (placaSeleccionada.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    placaSeleccionada.sUrlImg,
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