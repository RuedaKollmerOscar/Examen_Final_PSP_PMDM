import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbProcesador.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomAppBar.dart';
import '../../Widgets/CustomSnackbar.dart';

class ProcesadorView extends StatelessWidget {
  ProcesadorView({super.key});

  final FbProcesador procesador = DataHolder().procesadorSeleccionado;
  final String idProcesador = DataHolder().idProcesadorSeleccionado;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: procesador.sNombre,
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
                'Nombre: ${procesador.sNombre}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Marca: ${procesador.sMarca}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Modelo: ${procesador.sModelo}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Núcleos: ${procesador.iNucleos}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Hilos: ${procesador.iHilos}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Velocidad Base: ${procesador.dVelocidadBase} GHz',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Overclock: ${procesador.bOverclock ? 'Sí' : 'No'}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                'Precio: ${procesador.dPrecio} €',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              if (procesador.sUrlImg.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    procesador.sUrlImg,
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
    print("Editar producto con el id: $idProcesador");
  }

  Future<void> _eliminar() async {
    String mensaje = await DataHolder().fbadmin.eliminarComponente("procesadores", idProcesador);
    CustomSnackbar(sMensaje: mensaje).show(_context);
  }
}