import 'package:flutter/material.dart';
import 'package:techshop/Singletone/DataHolder.dart';

import '../Custom/Widgets/CustomSnackbar.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  TextEditingController tecNewPassword = TextEditingController();

  bool blsIsPassword = false;
  bool blsIsNewPassword = false;

  @override
  void initState() {
    super.initState();
    tecEmail.text = DataHolder().fbadmin.getCurrentUserEmail()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalizar Perfil'),
        centerTitle: true,
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
                        child: const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
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
                        onPressed: () {
                          // Acción para cambiar la imagen del perfil
                        },
                        child: const Text('Cambiar Imagen de Perfil'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: tecEmail,
                  decoration: const InputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'Ingresa tu correo electrónico actual',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: tecPassword,
                  decoration: InputDecoration(
                    labelText: 'Contraseña Actual',
                    hintText: 'Ingresa tu contraseña actual',
                    suffixIcon: IconButton(
                      icon: Icon(
                        blsIsPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          blsIsPassword = !blsIsPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !blsIsPassword,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: tecNewPassword,
                  decoration: InputDecoration(
                    labelText: 'Nueva Contraseña',
                    hintText: 'Ingresa tu nueva contraseña',
                    suffixIcon: IconButton(
                      icon: Icon(
                        blsIsNewPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        setState(() {
                          blsIsNewPassword = !blsIsNewPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: !blsIsNewPassword,
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
      Future<String?> result = DataHolder().fbadmin.iniciarSesion(tecEmail.text, tecPassword.text);
      result.then((mensajeError) async {
        if (mensajeError == null || mensajeError.isEmpty) {
          var user = DataHolder().fbadmin.getCurrentUser();
          if (user != null) {
            try {
              await user.updatePassword(tecNewPassword.text);
              CustomSnackbar(sMensaje: "Los cambios se guardaron correctamente").show(context);
            } catch (e) {
              CustomSnackbar(sMensaje: "Error al guardar los cambios").show(context);
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
    if (tecEmail.text.isEmpty && tecPassword.text.isEmpty && tecNewPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    } else if (tecEmail.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    } else if (tecPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    } else if (tecNewPassword.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de confirmación de contraseña');
    } else if (tecNewPassword.text.length < 8) {
      errorMessage.write('La contraseña debe tener al menos 8 caracteres');
    } else if (tecPassword.text == tecNewPassword.text) {
      errorMessage.write('Las contraseñas no pueden coincidir');
    }
    return errorMessage.toString();
  }
}
