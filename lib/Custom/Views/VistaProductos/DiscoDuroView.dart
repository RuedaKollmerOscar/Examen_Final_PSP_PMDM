import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbDiscoDuro.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CustomSnackbar.dart';
import '../EditView/EditarDiscoDuroView.dart';

class DiscoDuroView extends StatelessWidget {
  DiscoDuroView({super.key});

  final FbDiscoDuro discoDuro = DataHolder().discoDuroSeleccionado;
  final String idDiscoDuro = DataHolder().idDiscoDuroSeleccionado;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: discoDuro.sNombre,
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
                  'Nombre: ${discoDuro.sNombre}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Tipo: ${discoDuro.sTipo}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Almacenamiento: ${discoDuro.iAlmacenamiento}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Velocidad de lectura: ${discoDuro.iLectura} MB/s',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Velocidad de escritura: ${discoDuro.iEscritura} MB/s',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Precio: ${discoDuro.dPrecio} €',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                if (discoDuro.sUrlImg.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      discoDuro.sUrlImg,
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
        return EditarDiscoDuroView();
      },
    );
  }


  Future<void> _eliminar() async {
    String mensaje = await DataHolder().fbadmin.eliminarComponente("discosduros", idDiscoDuro);
    CustomSnackbar(sMensaje: mensaje).show(_context);
  }
}