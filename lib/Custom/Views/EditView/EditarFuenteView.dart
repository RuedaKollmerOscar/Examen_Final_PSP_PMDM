import 'package:flutter/material.dart';
import '../../../FirestoreObjects/FbFuente.dart';
import '../../../Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class EditarFuenteView extends StatefulWidget {
  const EditarFuenteView({Key? key}) : super(key: key);

  @override
  _EditarFuenteViewState createState() => _EditarFuenteViewState();
}

class _EditarFuenteViewState extends State<EditarFuenteView> {
  final FbFuente fuente = DataHolder().fuenteSeleccionada;
  final String idFuente = DataHolder().idFuenteSeleccionada;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecTipoCableado = TextEditingController();
  TextEditingController tecFormato = TextEditingController();
  TextEditingController tecPotencia = TextEditingController();
  TextEditingController tecCertificacion = TextEditingController();
  TextEditingController tecPrecio = TextEditingController();

  @override
  void initState() {
    tecNombre.text = fuente.sNombre;
    tecTipoCableado.text = fuente.sTipoCableado;
    tecFormato.text = fuente.sFormato;
    tecPotencia.text = fuente.iPotencia.toString();
    tecCertificacion.text = fuente.sCertificacion;
    tecPrecio.text = fuente.dPrecio.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text('Editar ${fuente.sNombre}'),
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
              controller: tecTipoCableado,
              decoration: const InputDecoration(labelText: 'Tipo de Cableado'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecFormato,
              decoration: const InputDecoration(labelText: 'Formato'),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecPotencia,
              decoration: const InputDecoration(labelText: 'Potencia (W)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: tecCertificacion,
              decoration: const InputDecoration(labelText: 'Certificación'),
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
    String? errorMessage = await DataHolder().fbadmin.editarFuente(
      idFuente,
      tecNombre.text,
      tecTipoCableado.text,
      tecFormato.text,
      int.parse(tecPotencia.text),
      tecCertificacion.text,
      double.parse(tecPrecio.text),
    );

    if (errorMessage == null) {
      const CustomSnackbar(sMensaje: 'Componente actualizada con éxito').show(context);
    } else {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
  }
}