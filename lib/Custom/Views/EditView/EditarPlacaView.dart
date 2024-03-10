import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbPlaca.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class EditarPlacaView extends StatefulWidget {
  const EditarPlacaView({Key? key}) : super(key: key);

  @override
  _EditarPlacaViewState createState() => _EditarPlacaViewState();
}

class _EditarPlacaViewState extends State<EditarPlacaView> {
  final FbPlaca placa = DataHolder().placaSeleccionada;
  final String idPlaca = DataHolder().idPlacaSeleccionada;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecFactorForma = TextEditingController();
  TextEditingController tecSocket = TextEditingController();
  TextEditingController tecChipset = TextEditingController();
  bool wifi = false;
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = placa.sNombre;
    tecFactorForma.text = placa.sFactorForma;
    tecSocket.text = placa.sSocket;
    tecChipset.text = placa.sChipset;
    wifi = placa.bWifi;
    tecPrecio.text = placa.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${placa.sNombre}'),
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
              controller: tecFactorForma,
              decoration: const InputDecoration(labelText: 'Factor de Forma'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecSocket,
              decoration: const InputDecoration(labelText: 'Socket'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecChipset,
              decoration: const InputDecoration(labelText: 'Chipset'),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: wifi,
                  onChanged: (value) {
                    setState(() {
                      wifi = value ?? false;
                    });
                  },
                ),
                Text('WiFi'),
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
    String? errorMessage = await DataHolder().fbadmin.editarPlaca(
      idPlaca,
      tecNombre.text,
      tecFactorForma.text,
      tecSocket.text,
      tecChipset.text,
      wifi,
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      CustomSnackbar(sMensaje: 'Placa actualizada con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}