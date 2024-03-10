import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbPlaca.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CustomSnackbar.dart';
import '../EditView/EditarPlacaView.dart';

class PlacaView extends StatelessWidget {
  PlacaView({super.key});

  final FbPlaca placa = DataHolder().placaSeleccionada;
  final String idPlaca = DataHolder().idPlacaSeleccionada;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: placa.sNombre,
        actions: [
          _buildPopupMenuButton(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nombre: ${placa.sNombre}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Factor de Forma: ${placa.sFactorForma}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Socket: ${placa.sSocket}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Chipset: ${placa.sChipset}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Wifi: ${placa.bWifi ? 'Sí' : 'No'}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Precio: ${placa.dPrecio} €',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                if (placa.sUrlImg.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      placa.sUrlImg,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  PopupMenuButton<String> _buildPopupMenuButton(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      icon: Icon(
        Icons.more_vert, // Tres puntos en vertical
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      color: Theme.of(context).colorScheme.background,
      onSelected: (caso) {
        switch (caso) {
          case 'editar':
            _editar();
            break;
          case 'eliminar':
            _eliminar();
            break;
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: 'editar',
          child: ListTile(
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              'Editar',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: 'eliminar',
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              'Eliminar',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _editar() {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return EditarPlacaView();
      },
    );
  }

  Future<void> _eliminar() async {
    String mensaje = await DataHolder().fbadmin.eliminarComponente("placasbase", idPlaca);
    CustomSnackbar(sMensaje: mensaje).show(_context);
  }
}