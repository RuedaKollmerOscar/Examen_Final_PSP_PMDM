import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackbar.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../Singletone/DataHolder.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPasswd = TextEditingController();
  final TextEditingController _tecConfirmPasswd = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Registro de usuario",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 50),

                CustomTextField(
                  sHint: "Correo electrónico",
                  blIsPasswd: false,
                  tecControler: _tecEmail,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Contraseña",
                  blIsPasswd: !_isPasswordVisible,
                  tecControler: _tecPasswd,
                  iconButton: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Confirmar contraseña",
                  blIsPasswd: true,
                  tecControler: _tecConfirmPasswd,
                ),

                const SizedBox(height: 25),

                CustomButton(
                  onTap: _registrarUsuario,
                  sText: "Registrate"
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿Ya tienes una cuenta?",
                      style: TextStyle(
                        color:
                        Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: _goToLogin,
                      child: const Text(
                        " Inicia sesión aquí",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Gestiona el texto de ¿Ya tienes una cuenta? Inicia sesión aquí
  void _goToLogin() {
    Navigator.of(context).popAndPushNamed("/loginview");
  }

  // Gestiona el boton de registrarse
  void _registrarUsuario() {
    String errorMessage = _checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      Future<String?> result = DataHolder().fbadmin.registrarUsuario(_tecEmail.text, _tecPasswd.text);
      result.then((mensajeError) {
        if (mensajeError == null || mensajeError.isEmpty) {
          Navigator.of(context).popAndPushNamed("/homeview");
        } else {
          CustomSnackbar(sMensaje: mensajeError).show(context);
        }
      });
    }
  }

  // Comprueba que todos los campos del register esten completos, la ultima comprobación comprueba que las contraseñas coincidan
  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecEmail.text.isEmpty && _tecPasswd.text.isEmpty && _tecConfirmPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }
    else if (_tecEmail.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    }
    else if (_tecPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    }
    else if (_tecConfirmPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de confirmación de contraseña');
    }
    else if (_tecPasswd.text != _tecConfirmPasswd.text) {
      errorMessage.write('Las contraseñas no coinciden');
    }
    return errorMessage.toString();
  }
}
