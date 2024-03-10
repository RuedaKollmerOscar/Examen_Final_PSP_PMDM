import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbGrafica.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class EditarGraficaView extends StatefulWidget {
  const EditarGraficaView({Key? key}) : super(key: key);

  @override
  _EditarGraficaViewState createState() => _EditarGraficaViewState();
}

class _EditarGraficaViewState extends State<EditarGraficaView> {
  final FbGrafica tarjetaGrafica = DataHolder().graficaSeleccionada;
  final String idTarjetaGrafica = DataHolder().idGraficaSeleccionada;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEnsamblador = TextEditingController();
  TextEditingController tecFabricante = TextEditingController();
  TextEditingController tecSerie = TextEditingController();
  TextEditingController tecCapacidad = TextEditingController();
  TextEditingController tecGeneracion = TextEditingController();
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = tarjetaGrafica.sNombre;
    tecEnsamblador.text = tarjetaGrafica.sEnsamblador;
    tecFabricante.text = tarjetaGrafica.sFabricante;
    tecSerie.text = tarjetaGrafica.sSerie;
    tecCapacidad.text = tarjetaGrafica.iCapacidad.toString();
    tecGeneracion.text = tarjetaGrafica.iGeneracion.toString();
    tecPrecio.text = tarjetaGrafica.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${tarjetaGrafica.sNombre}'),
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
              controller: tecEnsamblador,
              decoration: const InputDecoration(labelText: 'Ensamblador'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecFabricante,
              decoration: const InputDecoration(labelText: 'Fabricante'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecSerie,
              decoration: const InputDecoration(labelText: 'Serie'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecCapacidad,
              decoration: const InputDecoration(labelText: 'Capacidad (GB)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecGeneracion,
              decoration: const InputDecoration(labelText: 'Generación'),
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
    String? errorMessage = await DataHolder().fbadmin.editarGrafica(
      idTarjetaGrafica,
      tecNombre.text,
      tecEnsamblador.text,
      tecFabricante.text,
      tecSerie.text,
      int.parse(tecCapacidad.text),
      int.parse(tecGeneracion.text),
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      CustomSnackbar(sMensaje: 'Componente actualizada con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}