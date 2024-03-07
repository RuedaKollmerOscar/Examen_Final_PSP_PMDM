import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/FirestoreObjects/FbDisipador.dart'; // Asegúrate de importar el archivo correcto
import 'package:techshop/Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioDisipador extends StatefulWidget {
  const FormularioDisipador({super.key});

  @override
  _FormularioDisipadorState createState() => _FormularioDisipadorState();
}

class _FormularioDisipadorState extends State<FormularioDisipador> {
  String nombre = '';
  String color = '';
  String material = '';
  int velocidadRotacionMaxima = 0;
  int velocidadRotacionMinima = 0;
  double precio = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecColor = TextEditingController();
  final TextEditingController _tecMaterial = TextEditingController();
  final TextEditingController _tecVelocidadMaxima = TextEditingController();
  final TextEditingController _tecVelocidadMinima = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Nombre del disipador'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecColor,
                decoration: const InputDecoration(labelText: 'Color'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecMaterial,
                decoration: const InputDecoration(labelText: 'Material'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecVelocidadMinima,
                decoration: const InputDecoration(labelText: 'Velocidad de rotación mínima (RPM)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecVelocidadMaxima,
                decoration: const InputDecoration(labelText: 'Velocidad de rotación máxima (RPM)'),
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
                    onPressed: _subirDisipador,
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
    _tecColor.clear();
    _tecMaterial.clear();
    _tecVelocidadMaxima.clear();
    _tecVelocidadMinima.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirDisipador() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecColor.text.trim()}${_tecMaterial.text.trim()}${_tecVelocidadMaxima.text}${_tecVelocidadMinima.text}${_tecPrecio.text}";
      FbDisipador disipadorNuevo = FbDisipador(
        sNombre: _tecNombre.text.trim(),
        sColor: _tecColor.text.trim(),
        sMaterial: _tecMaterial.text.trim(),
        iVelocidadRotacionMaxima: int.parse(_tecVelocidadMaxima.text.trim()),
        iVelocidadRotacionMinima: int.parse(_tecVelocidadMinima.text.trim()),
        dPrecio: double.parse(_tecPrecio.text.trim()),
        sUrlImg: await DataHolder().fbadmin.subirFotoDisipador(_imagePreview, nombreNube),
      );
      errorMessage = await DataHolder().fbadmin.subirDisipador(disipadorNuevo);
      if (errorMessage == null) {
        CustomSnackbar(sMensaje: 'Se ha subido tu producto').show(context);
        _limpiarFormulario();
      } else CustomSnackbar(sMensaje: 'Se ha producido un error $errorMessage').show(context);
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty &&
        _tecColor.text.isEmpty &&
        _tecMaterial.text.isEmpty &&
        _tecVelocidadMaxima.text.isEmpty &&
        _tecVelocidadMinima.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecColor.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo color');
      }
      if (_tecMaterial.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo material');
      }
      if (_tecVelocidadMaxima.text.isEmpty) {
        errorMessage.write('Por favor, complete la velocidad de rotación máxima');
      }
      if (_tecVelocidadMinima.text.isEmpty) {
        errorMessage.write('Por favor, complete la velocidad de rotación mínima');
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