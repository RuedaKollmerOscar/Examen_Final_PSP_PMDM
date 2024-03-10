import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/FirestoreObjects/FbGrafica.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioGrafica extends StatefulWidget {
  const FormularioGrafica({super.key});

  @override
  _FormularioGraficaState createState() => _FormularioGraficaState();
}

class _FormularioGraficaState extends State<FormularioGrafica> {
  String nombre = '';
  String ensamblador = '';
  String fabricante = '';
  String serie = '';
  int capacidad = 0;
  int generacion = 0;
  double precio = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecEnsamblador = TextEditingController();
  final TextEditingController _tecFabricante = TextEditingController();
  final TextEditingController _tecSerie = TextEditingController();
  final TextEditingController _tecCapacidad = TextEditingController();
  final TextEditingController _tecGeneracion = TextEditingController();
  final TextEditingController _tecPrecio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _tecNombre,
                decoration: const InputDecoration(labelText: 'Nombre de la tarjeta gráfica'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecEnsamblador,
                decoration: const InputDecoration(labelText: 'Ensamblador'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecFabricante,
                decoration: const InputDecoration(labelText: 'Fabricante'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecSerie,
                decoration: const InputDecoration(labelText: 'Serie'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecCapacidad,
                decoration: const InputDecoration(labelText: 'Capacidad (GB)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecGeneracion,
                decoration: const InputDecoration(labelText: 'Generación'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecPrecio,
                decoration: const InputDecoration(labelText: 'Precio en euros'),
                keyboardType: TextInputType.number,
                onEditingComplete: () {
                  _tecPrecio.text += ' €';
                },
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: subirFoto,
                    child: const Text('Pon una foto'),
                  ),
                  ElevatedButton(
                    onPressed: _eliminarFoto,
                    child: const Text('Eliminar foto'),
                  ),
                ],
              ),
              Center(child: _fotoView()),

              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _subirGrafica,
                    child: const Text('Subir producto'),
                  ),
                  ElevatedButton(
                    onPressed: _limpiarFormulario,
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void subirFoto() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.camera,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Abrir cámara',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: _abrirCamara,
              ),
              Divider(
                thickness: 1,
                height: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Abrir galería',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: _abrirGaleria,
              ),
            ],
          ),
        );
      },
    );
  }

  void _eliminarFoto() {
    setState(() {
      _imagePreview = File("");
    });
  }

  void _abrirGaleria() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void _abrirCamara() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  Widget _fotoView() {
    if (_imagePreview.path.isEmpty || _imagePreview == null) {
      return const Text('No hay ninguna imagen para el producto');
    } else {
      return Image.file(
        _imagePreview,
        width: 500,
        height: 500,
      );
    }
  }

  void _limpiarFormulario() {
    _eliminarFoto();
    _tecNombre.clear();
    _tecEnsamblador.clear();
    _tecFabricante.clear();
    _tecSerie.clear();
    _tecCapacidad.clear();
    _tecGeneracion.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirGrafica() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecEnsamblador.text.trim()}${_tecFabricante.text.trim()}${_tecSerie.text.trim()}${_tecCapacidad.text}${_tecGeneracion.text}${_tecPrecio.text}";
      FbGrafica graficaNueva = FbGrafica(
        sNombre: _tecNombre.text.trim(),
        sEnsamblador: _tecEnsamblador.text.trim(),
        sFabricante: _tecFabricante.text.trim(),
        sSerie: _tecSerie.text.trim(),
        iCapacidad: int.parse(_tecCapacidad.text.trim()),
        iGeneracion: int.parse(_tecGeneracion.text.trim()),
        dPrecio: double.parse(_tecPrecio.text.trim()),
        sUrlImg: await DataHolder().fbadmin.subirFotoGrafica(_imagePreview, nombreNube),
      );
      errorMessage = await DataHolder().fbadmin.subirGrafica(graficaNueva);
      if (errorMessage == null) {
        const CustomSnackbar(sMensaje: 'Se ha subido tu producto').show(context);
        _limpiarFormulario();
      } else {
        CustomSnackbar(sMensaje: 'Se ha producido un error $errorMessage').show(context);
      }
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty &&
        _tecSerie.text.isEmpty &&
        _tecCapacidad.text.isEmpty &&
        _tecGeneracion.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecEnsamblador.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo ensamblador');
      }
      if (_tecFabricante.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo fabricante');
      }
      if (_tecSerie.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo serie');
      }
      if (_tecCapacidad.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo capacidad');
      }
      if (_tecGeneracion.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo generación');
      }
      if (_tecPrecio.text.isEmpty) {
        errorMessage.write('Por favor, complete el precio');
      }
      if (_imagePreview.path.isEmpty) {
        errorMessage.write('Por favor, adjunte una foto del producto');
      }
    }
    return errorMessage.toString();
  }
}
