import 'package:flutter/material.dart';
import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomTextField.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPasswd = TextEditingController();
  final TextEditingController tecConfirmPasswd = TextEditingController();

  bool isPasswordVisible = false;

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
                  tecControler: tecEmail,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Contraseña",
                  blIsPasswd: !isPasswordVisible,
                  tecControler: tecPasswd,
                  iconButton: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Confirmar contraseña",
                  blIsPasswd: true,
                  tecControler: tecConfirmPasswd,
                ),

                const SizedBox(height: 25),

                CustomButton(sText: "Registrate", onTap: () {}),

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
                      onTap: goToLogin,
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

  void goToLogin() {
    Navigator.of(context).popAndPushNamed("/loginview");
  }
}
