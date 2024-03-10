import 'package:flutter/material.dart';
import 'package:techshop/Custom/Widgets/CustomSnackbar.dart';
import '../../../FirestoreObjects/FbCaja.dart';
import '../../../Singletone/DataHolder.dart';

class EditarCajaView extends StatefulWidget {
  const EditarCajaView({Key? key}) : super(key: key);

  @override
  _EditarCajaViewState createState() => _EditarCajaViewState();
}

class _EditarCajaViewState extends State<EditarCajaView> {
  final FbCaja caja = DataHolder().cajaSeleccionada;
  final String idCaja = DataHolder().idCajaSeleccionada;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecColor = TextEditingController();
  TextEditingController tecPeso = TextEditingController();
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = caja.sNombre;
    tecColor.text = caja.sColor;
    tecPeso.text = caja.dPeso.toString();
    tecPrecio.text = caja.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${caja.sNombre}'),
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
              controller: tecColor,
              decoration: const InputDecoration(labelText: 'Color'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecPeso,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
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
                  onPressed: () {Navigator.of(context).pop();},
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
    String? errorMessage = await DataHolder().fbadmin.editarCaja(idCaja, tecNombre.text, tecColor.text, double.parse(tecPeso.text), double.parse(tecPrecio.text));
    if (errorMessage == null) {
      CustomSnackbar(sMensaje: 'Componente actualizado con éxito').show(context);
    } else CustomSnackbar(sMensaje: errorMessage).show(context);
  }
}
