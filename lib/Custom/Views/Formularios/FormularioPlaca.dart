import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/FirestoreObjects/FbPlaca.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioPlacaBase extends StatefulWidget {
  @override
  _FormularioPlacaBaseState createState() => _FormularioPlacaBaseState();
}

class _FormularioPlacaBaseState extends State<FormularioPlacaBase> {
  String nombre = '';
  String factorForma = '';
  String socket = '';
  String chipset = '';
  bool _wifi = false;
  double precio = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecFactorForma = TextEditingController();
  final TextEditingController _tecSocket = TextEditingController();
  final TextEditingController _tecChipset = TextEditingController();
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
                decoration: InputDecoration(labelText: 'Nombre de la placa base'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecFactorForma,
                decoration: InputDecoration(labelText: 'Factor de forma'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecSocket,
                decoration: InputDecoration(labelText: 'Socket'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _tecChipset,
                decoration: InputDecoration(labelText: 'Chipset'),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text('¿Tiene WiFi?'),
                  Checkbox(
                    value: _wifi,
                    onChanged: (value) {
                      setState(() {
                        _wifi = value!;
                      });
                    },
                  ),
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
                    onPressed: _subirPlacaBase,
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
    _tecFactorForma.clear();
    _tecSocket.clear();
    _tecChipset.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirPlacaBase() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecFactorForma.text.trim()}${_tecSocket.text.trim()}${_tecChipset.text.trim()}${_wifi}${_tecPrecio.text}";
      FbPlaca placaBaseNueva = FbPlaca(
        sNombre: _tecNombre.text.trim(),
        sFactorForma: _tecFactorForma.text.trim(),
        sSocket: _tecSocket.text.trim(),
        sChipset: _tecChipset.text.trim(),
        bWifi: _wifi,
        dPrecio: double.parse(_tecPrecio.text.trim()),
        sUrlImg: await DataHolder().fbadmin.subirFotoPlaca(_imagePreview, nombreNube),
      );
      DataHolder().fbadmin.subirPlaca(placaBaseNueva);
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty &&
        _tecFactorForma.text.isEmpty &&
        _tecSocket.text.isEmpty &&
        _tecChipset.text.isEmpty &&
        _tecPrecio.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecFactorForma.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo factor de forma');
      }
      if (_tecSocket.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo socket');
      }
      if (_tecChipset.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo chipset');
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