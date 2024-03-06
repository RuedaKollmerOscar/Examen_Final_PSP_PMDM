import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/Custom/Widgets/CustomSnackbar.dart';
import 'package:techshop/FirestoreObjects/FbCaja.dart';

import '../../../Singletone/DataHolder.dart';

class FormularioCaja extends StatefulWidget {
  const FormularioCaja({super.key});

  @override
  _FormularioCajaState createState() => _FormularioCajaState();
}

class _FormularioCajaState extends State<FormularioCaja> {
  String nombre = '';
  String color = '';
  double peso = 0.0;
  double precio = 0.0;
  final ImagePicker _picker=ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecColor = TextEditingController();
  final TextEditingController _tecPeso = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Nombre de la caja'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecColor,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecPeso,
                decoration: const InputDecoration(labelText: 'Peso en kilos'),
                keyboardType: TextInputType.number,
                onEditingComplete: () {
                  _tecPeso.text += ' kg';
                },
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
                    onPressed: _subirCaja,
                    child: const Text('Subir producto'),
                  ),
                  ElevatedButton(
                    onPressed: _cancelar,
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

  void _abrirGaleria() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
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
    _tecColor.clear();
    _tecPeso.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirCaja() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecColor.text.trim()}${_tecPrecio.text}${_tecPrecio.text}";
      FbCaja cajaNueva = FbCaja(
          sNombre: _tecNombre.text.trim(),
          sColor: _tecColor.text.trim(),
          dPeso: double.parse(_tecPeso.text.trim()),
          dPrecio: double.parse(_tecPrecio.text.trim()),
          sUrlImg: await DataHolder().fbadmin.subirFotoCaja(_imagePreview, nombreNube)
      );
      DataHolder().fbadmin.subirCaja(cajaNueva);
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty && _tecColor.text.isEmpty && _tecPeso.text.isEmpty && _tecPeso.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else if (_tecNombre.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo nombre');
    } else if (_tecColor.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo color');
    } else if (_tecPeso.text.isEmpty) {
      errorMessage.write('Por favor, complete el peso');
    } else if (_tecPrecio.text.isEmpty) {
      errorMessage.write('Por favor, complete el precio');
    } else if(_imagePreview.path.isEmpty) {
      errorMessage.write('Por favor, adjunte una foto del producto');
    }
    return errorMessage.toString();
  }
}