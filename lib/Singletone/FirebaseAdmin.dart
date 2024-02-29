import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAdmin {
  // Devuelve el ID del usuario logeado
  String? getCurrentUserID(){
    return FirebaseAuth.instance.currentUser?.uid;
  }

  // Devuelve el usuario logeado
  User? getCurrentUser(){
    return FirebaseAuth.instance.currentUser;
  }

  // Devuelve una instancia de la base de datos de autentificación
  FirebaseAuth getFirebaseAuthInstance(){
    return FirebaseAuth.instance;
  }

  // Incia sesión con un correo y una contraseña que se le pasa por parámetro
  Future<String?> iniciarSesion(String email, String password) async {
    String? errorMessage;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Correo no econtrado
        errorMessage ='Ningún usuario encontrado para ese correo electrónico.';
      } else if (e.code == 'wrong-password') {
        // Contraseña incorrecta
        errorMessage ='Contraseña incorrecta proporcionada para ese correo electrónico.';
      } else {
        // Otras excepciones de FirebaseAuth
        errorMessage = 'Error de autenticación: ${e.message}';
      }
    } catch (e) {
      // Otras excepciones no relacionadas con FirebaseAuth
      errorMessage ='Error: $e';
    }
    return errorMessage;
  }
}