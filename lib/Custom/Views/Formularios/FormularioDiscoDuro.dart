import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/FirestoreObjects/FbDiscoDuro.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioDiscoDuro extends StatefulWidget {
  const FormularioDiscoDuro({super.key});

  @override
  _FormularioDiscoDuroState createState() => _FormularioDiscoDuroState();
}

class _FormularioDiscoDuroState extends State<FormularioDiscoDuro> {
  String nombre = '';
  String tipo = '';
  double velocidadEscritura = 0.0;
  double velocidadLectura = 0.0;
  double precio = 0.0;
  double almacenamiento = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecTipo = TextEditingController();
  final TextEditingController _tecVelocidadEscritura = TextEditingController();
  final TextEditingController _tecVelocidadLectura = TextEditingController();
  final TextEditingController _tecPrecio = TextEditingController();
  final TextEditingController _tecAlmacenamiento = TextEditingController();

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
                decoration: const InputDecoration(labelText: 'Nombre del disco duro'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecTipo,
                decoration: const InputDecoration(labelText: 'Tipo de disco duro'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecAlmacenamiento,
                decoration: const InputDecoration(labelText: 'Almacenamiento en GB'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecVelocidadEscritura,
                decoration: const InputDecoration(labelText: 'Velocidad de escritura (MB/s)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecVelocidadLectura,
                decoration: const InputDecoration(labelText: 'Velocidad de lectura (MB/s)'),
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
                    onPressed: _subirDiscoDuro,
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

  void _limpiarFormulario() {
    _eliminarFoto();
    _tecNombre.clear();
    _tecTipo.clear();
    _tecVelocidadEscritura.clear();
    _tecVelocidadLectura.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirDiscoDuro() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecTipo.text.trim()}${_tecVelocidadEscritura.text}${_tecVelocidadLectura.text}${_tecPrecio.text}";
      FbDiscoDuro discoDuroNuevo = FbDiscoDuro(
          sNombre: _tecNombre.text.trim(),
          sTipo: _tecTipo.text.trim(),
          iAlmacenamiento: int.parse(_tecAlmacenamiento.text.trim()),
          iEscritura: int.parse(_tecVelocidadEscritura.text.trim()),
          iLectura: int.parse(_tecVelocidadLectura.text.trim()),
          dPrecio: double.parse(_tecPrecio.text.trim()),
          sUrlImg: await DataHolder().fbadmin.subirFotoDiscoDuro(_imagePreview, nombreNube)
    );
      errorMessage = await DataHolder().fbadmin.subirDiscoDuro(discoDuroNuevo);
      if (errorMessage == null) {
        CustomSnackbar(sMensaje: 'Se ha subido tu producto').show(context);
        _limpiarFormulario();
      } else CustomSnackbar(sMensaje: 'Se ha producido un error $errorMessage').show(context);
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();

    if (_tecNombre.text.isEmpty &&
        _tecTipo.text.isEmpty &&
        _tecVelocidadEscritura.text.isEmpty &&
        _tecVelocidadLectura.text.isEmpty &&
        _tecPrecio.text.isEmpty &&
        _tecAlmacenamiento.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecTipo.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo tipo');
      }
      if (_tecVelocidadEscritura.text.isEmpty) {
        errorMessage.write('Por favor, complete la velocidad de escritura');
      }
      if (_tecVelocidadLectura.text.isEmpty) {
        errorMessage.write('Por favor, complete la velocidad de lectura');
      }
      if (_tecPrecio.text.isEmpty) {
        errorMessage.write('Por favor, complete el precio');
      }
      if (_tecAlmacenamiento.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo de almacenamiento');
      }
      if (_imagePreview.path.isEmpty) {
        errorMessage.write('Por favor, adjunte una foto del producto');
      }
    }
    return errorMessage.toString();
  }
}