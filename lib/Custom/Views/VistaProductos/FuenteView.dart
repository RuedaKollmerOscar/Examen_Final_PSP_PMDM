import 'package:flutter/material.dart';
import 'package:techshop/FirestoreObjects/FbFuente.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CustomSnackbar.dart';

class FuenteView extends StatelessWidget {
  FuenteView({super.key});

  final FbFuente fuente = DataHolder().fuenteSeleccionada;
  final String idFuente = DataHolder().idFuenteSeleccionada;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
  _context = context;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: fuente.sNombre,
        actions: [
          _buildPopupMenuButton(context),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre: ${fuente.sNombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Tipo de Cableado: ${fuente.sTipoCableado}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Formato: ${fuente.sFormato}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Potencia: ${fuente.iPotencia} W',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Certificación: ${fuente.sCertificacion}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: ${fuente.dPrecio} €',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (fuente.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    fuente.sUrlImg,
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
    print("Editar producto con el id: $idFuente");
  }

  Future<void> _eliminar() async {
    String mensaje = await DataHolder().fbadmin.eliminarComponente("fuentesalimentacion", idFuente);
    CustomSnackbar(sMensaje: mensaje).show(_context);
  }
}