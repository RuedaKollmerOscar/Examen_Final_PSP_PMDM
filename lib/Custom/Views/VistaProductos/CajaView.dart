import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbCaja.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CustomSnackbar.dart';
import '../EditView/EditarCajaView.dart';

class CajaView extends StatelessWidget {
  CajaView({super.key});

  final FbCaja caja = DataHolder().cajaSeleccionada;
  final String idCaja = DataHolder().idCajaSeleccionada;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: caja.sNombre,
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
                  'Nombre: ${caja.sNombre}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Ajusta el tamaño del texto
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Color: ${caja.sColor}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Peso: ${caja.dPeso} kg',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Precio: ${caja.dPrecio} €',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                if (caja.sUrlImg.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      caja.sUrlImg,
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
            _editar(context);
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

  Future<void> _editar(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const EditarCajaView();
      },
    );
  }

  Future<void> _eliminar() async {
    String mensaje = await DataHolder().fbadmin.eliminarComponente("cajas", idCaja);
    CustomSnackbar(sMensaje: mensaje).show(_context);
  }
}
