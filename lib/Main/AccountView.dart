import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techshop/Singletone/DataHolder.dart';

import '../Custom/Widgets/CustomAppBar.dart';
import '../Custom/Widgets/CustomSnackbar.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final ImagePicker _picker=ImagePicker();
  File _imagePreview = File("");
  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();
  final TextEditingController _tecNewPassword = TextEditingController();

  bool _blsIsPassword = false;
  bool _blsIsNewPassword = false;

  @override
  void initState() {
    super.initState();
    _tecEmail.text = DataHolder().fbadmin.getCurrentUserEmail()!;
    _cargarFotoPerfil();
  }

  // Método asincrónico para cargar la foto de perfil
  Future<void> _cargarFotoPerfil() async {
    _imagePreview = (await DataHolder().fbadmin.descargarFotoPerfil())!;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: 'Personalizar perfil',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: ClipOval(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: _fotoPerfilView(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Nombre de Usuario',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '@nombreusuario',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: cambiarFotoPerfil,
                        child: const Text('Cambiar foto de perfil'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _tecEmail,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'Ingresa tu correo electrónico actual',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _tecPassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña Actual',
                    hintText: 'Ingresa tu contraseña actual',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _blsIsPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _blsIsPassword = !_blsIsPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_blsIsPassword,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _tecNewPassword,
                  decoration: InputDecoration(
                    labelText: 'Nueva Contraseña',
                    hintText: 'Ingresa tu nueva contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _blsIsNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          _blsIsNewPassword = !_blsIsNewPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !_blsIsNewPassword,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: guardarCambios,
                  child: const Text('Guardar Cambios'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Gestiona el boton de inicar sesión
  void guardarCambios() {
    String errorMessage = checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      Future<String?> result = DataHolder().fbadmin.iniciarSesion(_tecEmail.text, _tecPassword.text);
      result.then((mensajeError) async {
        if (mensajeError == null || mensajeError.isEmpty) {
          var user = DataHolder().fbadmin.getCurrentUser();
          if (user != null) {
            try {
              await user.updatePassword(_tecNewPassword.text);
              const CustomSnackbar(sMensaje: "Los cambios se guardaron correctamente. Reinicia la aplicación").show(context);
            } catch (e) {
              const CustomSnackbar(sMensaje: "Error al guardar los cambios").show(context);
            }
          }
        } else {
          CustomSnackbar(sMensaje: mensajeError).show(context);
        }
      }
      );
    }
  }

  String checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecEmail.text.isEmpty && _tecPassword.text.isEmpty && _tecNewPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else if (_tecEmail.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    } else if (_tecPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    } else if (_tecNewPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de confirmación de contraseña');
    } else if (_tecNewPassword.text.length < 8) {
      errorMessage.write('La contraseña debe tener al menos 8 caracteres');
    } else if (_tecPassword.text == _tecNewPassword.text) {
      errorMessage.write('Las contraseñas no pueden coincidir');
    }
    return errorMessage.toString();
  }

  void cambiarFotoPerfil() {
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

  void _abrirGaleria() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        _imagePreview=File(image.path);
      });
      DataHolder().fbadmin.subirFotoPerfil(_imagePreview);
    }
  }

  void _abrirCamara() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
      DataHolder().fbadmin.subirFotoPerfil(_imagePreview);
    }
  }

  Widget _fotoPerfilView() {
    if (_imagePreview.path.isEmpty || _imagePreview == null) {
      return const Icon(
        Icons.person,
        size: 50
      );
    } else {
      return Image.file(
        _imagePreview,
        width: 100,
        height: 100,
        fit: BoxFit.cover
      );
    }
  }
}