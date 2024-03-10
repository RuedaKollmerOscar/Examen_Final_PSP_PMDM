import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbRAM.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class EditarRAMView extends StatefulWidget {
  const EditarRAMView({Key? key}) : super(key: key);

  @override
  _EditarRAMViewState createState() => _EditarRAMViewState();
}

class _EditarRAMViewState extends State<EditarRAMView> {
  final FbRAM ram = DataHolder().ramSeleccionada;
  final String idRAM = DataHolder().idRAMSeleccionada;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecCapacidad = TextEditingController();
  TextEditingController tecCantidadModulos = TextEditingController();
  TextEditingController tecVelocidad = TextEditingController();
  TextEditingController tecGeneracion = TextEditingController();
  bool bRGB = false; // Nuevo campo booleano para RGB
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = ram.sNombre;
    tecCapacidad.text = ram.iCapacidad.toString();
    tecCantidadModulos.text = ram.iModulos.toString();
    tecVelocidad.text = ram.iVelocidad.toString();
    tecGeneracion.text = ram.iGeneracion.toString();
    bRGB = ram.bRGB;
    tecPrecio.text = ram.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${ram.sNombre}'),
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
              controller: tecCapacidad,
              decoration: const InputDecoration(labelText: 'Capacidad (GB)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecCantidadModulos,
              decoration: const InputDecoration(labelText: 'Cantidad de Módulos'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecVelocidad,
              decoration: const InputDecoration(labelText: 'Velocidad (MHz)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecGeneracion,
              decoration: const InputDecoration(labelText: 'Generación'),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: bRGB,
                  onChanged: (value) {
                    setState(() {
                      bRGB = value ?? false;
                    });
                  },
                ),
                const Text('RGB'),
              ],
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
    String? errorMessage = await DataHolder().fbadmin.editarRAM(
      idRAM,
      tecNombre.text,
      int.parse(tecCapacidad.text),
      int.parse(tecCantidadModulos.text),
      int.parse(tecVelocidad.text),
      int.parse(tecGeneracion.text),
      bRGB,
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      const CustomSnackbar(sMensaje: 'Componente actualizado con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}