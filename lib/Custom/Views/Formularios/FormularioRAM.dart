import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../../../FirestoreObjects/FbRAM.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioRAM extends StatefulWidget {
  const FormularioRAM({super.key});

  @override
  _FormularioRAMState createState() => _FormularioRAMState();
}

class _FormularioRAMState extends State<FormularioRAM> {
  String nombre = '';
  int capacidadGB = 0;
  int cantidadModulos = 0;
  int velocidadMHz = 0;
  int generacion = 0;
  bool tieneRGB = false;
  double precio = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecCapacidadGB = TextEditingController();
  final TextEditingController _tecCantidadModulos = TextEditingController();
  final TextEditingController _tecVelocidadMHz = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Nombre de la RAM'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecCapacidadGB,
                decoration: const InputDecoration(labelText: 'Capacidad (GB)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecCantidadModulos,
                decoration: const InputDecoration(labelText: 'Cantidad de módulos'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecVelocidadMHz,
                decoration: const InputDecoration(labelText: 'Velocidad (MHz)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecGeneracion,
                decoration: const InputDecoration(labelText: 'Generación'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: tieneRGB,
                    onChanged: (value) {
                      setState(() {
                        tieneRGB = value ?? false;
                      });
                    },
                  ),
                  const Text('Tiene RGB'),
                ],
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
                    onPressed: _subirRAM,
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
    _tecCapacidadGB.clear();
    _tecCantidadModulos.clear();
    _tecVelocidadMHz.clear();
    _tecGeneracion.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirRAM() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecCapacidadGB.text}${_tecCantidadModulos.text}${_tecVelocidadMHz.text}${_tecGeneracion.text}$tieneRGB${_tecPrecio.text}";
      FbRAM ramNueva = FbRAM(
        sNombre: _tecNombre.text.trim(),
        iCapacidad: int.parse(_tecCapacidadGB.text.trim()),
        iModulos: int.parse(_tecCantidadModulos.text.trim()),
        iVelocidad: int.parse(_tecVelocidadMHz.text.trim()),
        iGeneracion: int.parse(_tecGeneracion.text.trim()),
        bRGB: tieneRGB,
        dPrecio: double.parse(_tecPrecio.text.trim()),
        sUrlImg: await DataHolder().fbadmin.subirFotoRAM(_imagePreview, nombreNube),
      );
      errorMessage = await DataHolder().fbadmin.subirRAM(ramNueva);
      if (errorMessage == null) {
        CustomSnackbar(sMensaje: 'Se ha subido tu producto').show(context);
        _limpiarFormulario();
      } else CustomSnackbar(sMensaje: 'Se ha producido un error $errorMessage').show(context);    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty &&
        _tecCapacidadGB.text.isEmpty &&
        _tecCantidadModulos.text.isEmpty &&
        _tecVelocidadMHz.text.isEmpty &&
        _tecGeneracion.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecCapacidadGB.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo capacidad (GB)');
      }
      if (_tecCantidadModulos.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo cantidad de módulos');
      }
      if (_tecVelocidadMHz.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo velocidad (MHz)');
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
