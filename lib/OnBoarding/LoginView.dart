import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomSnackbar.dart';
import '../Custom/Widgets/CustomTextField.dart';
import '../Singletone/DataHolder.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPasswd = TextEditingController();

  bool _blsIsPassword = false;

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
                  Icons.lock,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Inicio de sesión",
                  style: TextStyle(fontSize: 20),
                ),

                const SizedBox(height: 50),

                CustomTextField(
                    sHint: "Correo electrónico",
                    blIsPasswd: false,
                    tecControler: _tecEmail),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Contraseña",
                  blIsPasswd: !_blsIsPassword,
                  tecControler: _tecPasswd,
                  iconButton: IconButton(
                    icon: Icon(
                      _blsIsPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        _blsIsPassword = !_blsIsPassword;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 25),

                CustomButton(
                  onTap: _iniciarSesion,
                  sText: "Inicar sesión",
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary)),
                    GestureDetector(
                      onTap: _goToRegister,
                      child: const Text(
                        " Registrate aquí",
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

  // Gestiona el texto de ¿No tienes cuenta? Registrate aquí
  void _goToRegister() {
    Navigator.of(context).popAndPushNamed("/registerview");
  }

  // Gestiona el boton de inicar sesión
  void _iniciarSesion() {
    String errorMessage = _checkFields();

    if(errorMessage.isNotEmpty){
      CustomSnackbar(sMensaje: errorMessage).show(context);
    }
    else if (errorMessage.isEmpty) {
      Future<String?> result = DataHolder().fbadmin.iniciarSesion(_tecEmail.text, _tecPasswd.text);
      result.then((mensajeError) async {
        if (mensajeError == null || mensajeError.isEmpty) {
          Navigator.of(context).popAndPushNamed("/homeview");
        } else {
          CustomSnackbar(sMensaje: mensajeError).show(context);
        }
      }
      );
    }
  }

  // Comprueba que todos los campos del login esten completos
  String _checkFields() {
    StringBuffer errorMessage = StringBuffer();
    if (_tecEmail.text.isEmpty && _tecPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete todos los campos');
    }
    else if (_tecEmail.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de correo electrónico');
    }
    else if (_tecPasswd.text.isEmpty) {
      errorMessage.write('Por favor, complete el campo de contraseña');
    }
    return errorMessage.toString();
  }
}