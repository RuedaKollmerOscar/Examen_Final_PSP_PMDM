import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbDisipador.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class EditarDisipadorView extends StatefulWidget {
  const EditarDisipadorView({Key? key}) : super(key: key);

  @override
  _EditarDisipadorViewState createState() => _EditarDisipadorViewState();
}

class _EditarDisipadorViewState extends State<EditarDisipadorView> {
  final FbDisipador disipador = DataHolder().disipadorSeleccionado;
  final String idDisipador = DataHolder().idDisipadorSeleccionado;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecMaterial = TextEditingController();
  TextEditingController tecVelocidadMinima = TextEditingController();
  TextEditingController tecVelocidadMaxima = TextEditingController();
  TextEditingController tecPrecio = TextEditingController();
  TextEditingController tecColor = TextEditingController(); // Nuevo campo de color

  @override
  void initState() {
    tecNombre.text = disipador.sNombre;
    tecMaterial.text = disipador.sMaterial;
    tecVelocidadMinima.text = disipador.iVelocidadRotacionMinima.toString();
    tecVelocidadMaxima.text = disipador.iVelocidadRotacionMaxima.toString();
    tecPrecio.text = disipador.dPrecio.toString();
    tecColor.text = disipador.sColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${disipador.sNombre}'),
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
              controller: tecMaterial,
              decoration: const InputDecoration(labelText: 'Material'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecColor,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecVelocidadMinima,
              decoration: const InputDecoration(labelText: 'Velocidad Mínima (RPM)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecVelocidadMaxima,
              decoration: const InputDecoration(labelText: 'Velocidad Máxima (RPM)'),
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
    String? errorMessage = await DataHolder().fbadmin.editarDisipador(
      idDisipador,
      tecNombre.text,
      tecColor.text,
      tecMaterial.text,
      int.parse(tecVelocidadMinima.text),
      int.parse(tecVelocidadMaxima.text),
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      const CustomSnackbar(sMensaje: 'Componente actualizado con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}
