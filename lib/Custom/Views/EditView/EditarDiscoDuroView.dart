import 'package:flutter/material.dart';
import 'package:techshop/Custom/Widgets/CustomSnackbar.dart';
import '../../../FirestoreObjects/FbDiscoDuro.dart';
import '../../../Singletone/DataHolder.dart';

class EditarDiscoDuroView extends StatefulWidget {
  const EditarDiscoDuroView({Key? key}) : super(key: key);

  @override
  _EditarDiscoDuroViewState createState() => _EditarDiscoDuroViewState();
}

class _EditarDiscoDuroViewState extends State<EditarDiscoDuroView> {
  final FbDiscoDuro discoDuro = DataHolder().discoDuroSeleccionado;
  final String idDiscoDuro = DataHolder().idDiscoDuroSeleccionado;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecTipo = TextEditingController();
  TextEditingController tecVelocidadEscritura = TextEditingController();
  TextEditingController tecVelocidadLectura = TextEditingController();
  TextEditingController tecAlmacenamiento = TextEditingController();
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = discoDuro.sNombre;
    tecTipo.text = discoDuro.sTipo;
    tecVelocidadEscritura.text = discoDuro.iEscritura.toString();
    tecVelocidadLectura.text = discoDuro.iLectura.toString();
    tecAlmacenamiento.text = discoDuro.iAlmacenamiento.toString();
    tecPrecio.text = discoDuro.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${discoDuro.sNombre}'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: tecNombre,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecTipo,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecAlmacenamiento,
              decoration: const InputDecoration(labelText: 'Almacenamiento (GB)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecVelocidadLectura,
              decoration: const InputDecoration(labelText: 'Velocidad de lectura'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecVelocidadEscritura,
              decoration: const InputDecoration(labelText: 'Velocidad de escritura'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecPrecio,
              decoration: const InputDecoration(labelText: 'Precio (€)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _guardarCambios();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarCambios() async {
    String? errorMessage = await DataHolder().fbadmin.editarDiscoDuro(
      idDiscoDuro,
      tecNombre.text,
      tecTipo.text,
      int.parse(tecVelocidadEscritura.text),
      int.parse(tecVelocidadLectura.text),
      int.parse(tecAlmacenamiento.text),
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      CustomSnackbar(sMensaje: 'Componente actualizado con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}
