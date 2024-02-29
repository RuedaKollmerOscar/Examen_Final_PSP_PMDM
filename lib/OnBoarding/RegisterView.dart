import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomTextField.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPasswd = TextEditingController();
  final TextEditingController tecConfirmPasswd = TextEditingController();

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
                  blIsPasswd: true,
                  tecControler: tecPasswd,
                ),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Confirmar contraseña",
                  blIsPasswd: true,
                  tecControler: tecConfirmPasswd,
                ),

                const SizedBox(height: 25),

                CustomButton(sText: "Registrate", onTap: () => null),

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
                      onTap: () => null,
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
    );  }
}