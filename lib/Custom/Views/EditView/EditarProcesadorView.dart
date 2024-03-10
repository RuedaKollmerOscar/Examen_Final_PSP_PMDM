import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbProcesador.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class EditarProcesadorView extends StatefulWidget {
  const EditarProcesadorView({Key? key}) : super(key: key);

  @override
  _EditarProcesadorViewState createState() => _EditarProcesadorViewState();
}

class _EditarProcesadorViewState extends State<EditarProcesadorView> {
  final FbProcesador procesador = DataHolder().procesadorSeleccionado;
  final String idProcesador = DataHolder().idProcesadorSeleccionado;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecMarca = TextEditingController();
  TextEditingController tecModelo = TextEditingController();
  TextEditingController tecNucleos = TextEditingController();
  TextEditingController tecHilos = TextEditingController();
  TextEditingController tecVelocidadBase = TextEditingController();
  bool bOverclock = false;
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = procesador.sNombre;
    tecMarca.text = procesador.sMarca;
    tecModelo.text = procesador.sModelo;
    tecNucleos.text = procesador.iNucleos.toString();
    tecHilos.text = procesador.iHilos.toString();
    tecVelocidadBase.text = procesador.dVelocidadBase.toString();
    bOverclock = procesador.bOverclock;
    tecPrecio.text = procesador.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${procesador.sNombre}'),
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
              controller: tecMarca,
              decoration: const InputDecoration(labelText: 'Marca'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecModelo,
              decoration: const InputDecoration(labelText: 'Modelo'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecNucleos,
              decoration: const InputDecoration(labelText: 'Núcleos'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecHilos,
              decoration: const InputDecoration(labelText: 'Hilos'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecVelocidadBase,
              decoration: const InputDecoration(labelText: 'Velocidad Base (GHz)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: bOverclock,
                  onChanged: (value) {
                    setState(() {
                      bOverclock = value ?? false;
                    });
                  },
                ),
                const Text('Overclock'),
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
    String? errorMessage = await DataHolder().fbadmin.editarProcesador(
      idProcesador,
      tecNombre.text,
      tecMarca.text,
      tecModelo.text,
      int.parse(tecNucleos.text),
      int.parse(tecHilos.text),
      double.parse(tecVelocidadBase.text),
      bOverclock,
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      const CustomSnackbar(sMensaje: 'Componente actualizado con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}
