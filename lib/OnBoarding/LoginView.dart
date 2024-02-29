import 'package:flutter/material.dart';

import '../Custom/Widgets/CustomButton.dart';
import '../Custom/Widgets/CustomTextField.dart';

class LoginView extends StatelessWidget {

  final TextEditingController tecEmail = TextEditingController();
  final TextEditingController tecPasswd = TextEditingController();

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
                    tecControler: tecEmail),

                const SizedBox(height: 10),

                CustomTextField(
                  sHint: "Contraseña",
                  blIsPasswd: true,
                  tecControler: tecPasswd,
                ),

                const SizedBox(height: 25),

                CustomButton(
                  onTap: () => null,
                  sText: "Inicar sesión",
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "¿No tienes cuenta?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary)
                    ),
                    GestureDetector(
                      onTap: () => null,
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
}