import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../../../FirestoreObjects/FbFuente.dart';
import '../../Widgets/CustomSnackbar.dart';

class FormularioFuente extends StatefulWidget {
  const FormularioFuente({super.key});

  @override
  _FormularioFuenteState createState() => _FormularioFuenteState();
}

class _FormularioFuenteState extends State<FormularioFuente> {
  String nombre = '';
  String certificacion = '';
  String tipoCableado = '';
  String formato = '';
  int potencia = 0;
  double precio = 0.0;
  final ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecNombre = TextEditingController();
  final TextEditingController _tecCertificacion = TextEditingController();
  final TextEditingController _tecTipoCableado = TextEditingController();
  final TextEditingController _tecFormato = TextEditingController();
  final TextEditingController _tecPotencia = TextEditingController();
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
                decoration: const InputDecoration(labelText: 'Nombre de la fuente'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecCertificacion,
                decoration: const InputDecoration(labelText: 'Certificación'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecTipoCableado,
                decoration: const InputDecoration(labelText: 'Tipo de cableado'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecFormato,
                decoration: const InputDecoration(labelText: 'Factor de forma'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tecPotencia,
                decoration: const InputDecoration(labelText: 'Potencia (W)'),
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
                    onPressed: _subirFuente,
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
    _tecCertificacion.clear();
    _tecTipoCableado.clear();
    _tecFormato.clear();
    _tecPotencia.clear();
    _tecPrecio.clear();
  }

  Future<void> _subirFuente() async {
    String? errorMessage = _checkFields();
    if (errorMessage.isNotEmpty) {
      CustomSnackbar(sMensaje: errorMessage).show(context);
    } else if (errorMessage.isEmpty) {
      String nombreNube = "${_tecNombre.text.trim()}${_tecCertificacion.text.trim()}${_tecTipoCableado.text.trim()}${_tecFormato.text.trim()}${_tecPotencia.text}${_tecPrecio.text}";
      FbFuente fuenteNueva = FbFuente(
        sNombre: _tecNombre.text.trim(),
        sCertificacion: _tecCertificacion.text.trim(),
        sTipoCableado: _tecTipoCableado.text.trim(),
        sFormato: _tecFormato.text.trim(),
        iPotencia: int.parse(_tecPotencia.text.trim()),
        dPrecio: double.parse(_tecPrecio.text.trim()),
        sUrlImg: await DataHolder().fbadmin.subirFotoFuente(_imagePreview, nombreNube),
      );
      DataHolder().fbadmin.subirFuente(fuenteNueva);
    }
  }

  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecNombre.text.isEmpty &&
        _tecCertificacion.text.isEmpty &&
        _tecTipoCableado.text.isEmpty &&
        _tecFormato.text.isEmpty &&
        _tecPotencia.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else {
      if (_tecNombre.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo nombre');
      }
      if (_tecCertificacion.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo certificación');
      }
      if (_tecTipoCableado.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo tipo de cableado');
      }
      if (_tecFormato.text.isEmpty) {
        errorMessage.write('Por favor, complete el campo formato');
      }
      if (_tecPotencia.text.isEmpty) {
        errorMessage.write('Por favor, complete la potencia');
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
