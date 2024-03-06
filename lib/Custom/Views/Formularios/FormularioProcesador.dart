import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../../../FirestoreObjects/FbProcesador.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioProcesador extends StatefulWidget {
  @override
  _FormularioProcesadorState createState() => _FormularioProcesadorState();
}

class _FormularioProcesadorState extends State<FormularioProcesador> {
  String nombre = '';
  String marca = '';
  String modelo = '';
  int numeroNucleos = 0;
  int numeroHilos = 0;
  double velocidadReloj = 0.0;
  bool overclock = false;
  double precio = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecMarca = TextEditingController();
  final TextEditingController _tecModelo = TextEditingController();
  final TextEditingController _tecNumeroNucleos = TextEditingController();
  final TextEditingController _tecNumeroHilos = TextEditingController();
  final TextEditingController _tecVelocidadReloj = TextEditingController();
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
                decoration: InputDecoration(labelText: 'Nombre del procesador'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecMarca,
                decoration: InputDecoration(labelText: 'Marca del procesador'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecModelo,
                decoration: InputDecoration(labelText: 'Modelo del procesador'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecNumeroNucleos,
                decoration: InputDecoration(labelText: 'Número de núcleos'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecNumeroHilos,
                decoration: InputDecoration(labelText: 'Número de hilos'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecVelocidadReloj,
                decoration: InputDecoration(labelText: 'Velocidad de reloj (GHz)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: overclock,
                    onChanged: (value) {
                      setState(() {
                        overclock = value ?? false;
                      });
                    },
                  ),
                  Text('¿Permite overclock?'),
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecPrecio,
                decoration: InputDecoration(labelText: 'Precio en euros'),
                keyboardType: TextInputType.number,
                onEditingComplete: () {
                  _tecPrecio.text += ' €';
                },
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: subirFoto,
                    child: Text('Pon una foto'),
                  ),
                  ElevatedButton(
                    onPressed: _eliminarFoto,
                    child: Text('Eliminar foto'),
                  ),
                ],
              ),
              Center(child: _fotoView()),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _subirProcesador,
                    child: Text('Subir producto'),
                  ),
                  ElevatedButton(
                    onPressed: _cancelar,
                    child: Text('Cancelar'),
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

  void _cancelar() {
    _eliminarFoto();
    _tecNombre.clear();
    _tecMarca.clear();
    _tecModelo.clear();
    _tecNumeroNucleos.clear();
    _tecNumeroHilos.clear();
    _tecVelocidadReloj.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirProcesador() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecMarca.text.trim()}${_tecModelo.text.trim()}${_tecNumeroNucleos.text}${_tecNumeroHilos.text}${_tecVelocidadReloj.text}${overclock}${_tecPrecio.text}";
      FbProcesador procesadorNuevo = FbProcesador(
        sNombre: _tecNombre.text.trim(),
        sMarca: _tecMarca.text.trim(),
        sModelo: _tecModelo.text.trim(),
        iNucleos: int.parse(_tecNumeroNucleos.text.trim()),
        iHilos: int.parse(_tecNumeroHilos.text.trim()),
        dVelocidadBase: double.parse(_tecVelocidadReloj.text.trim()),
        bOverclock: overclock,
        dPrecio: double.parse(_tecPrecio.text.trim()),
        sUrlImg: await DataHolder().fbadmin.subirFotoProcesador(_imagePreview, nombreNube),
      );
      DataHolder().fbadmin.subirProcesador(procesadorNuevo);
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty &&
        _tecMarca.text.isEmpty &&
        _tecModelo.text.isEmpty &&
        _tecNumeroNucleos.text.isEmpty &&
        _tecNumeroHilos.text.isEmpty &&
        _tecVelocidadReloj.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecMarca.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo marca');
      }
      if (_tecModelo.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo modelo');
      }
      if (_tecNumeroNucleos.text.isEmpty) {
        errorMessage.write('Por favor, complete el número de núcleos');
      }
      if (_tecNumeroHilos.text.isEmpty) {
        errorMessage.write('Por favor, complete el número de hilos');
      }
      if (_tecVelocidadReloj.text.isEmpty) {
        errorMessage.write('Por favor, complete la velocidad de reloj');
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