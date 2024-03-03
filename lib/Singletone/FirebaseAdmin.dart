import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techshop/FirestoreObjects/FbComponente.dart';

import '../FirestoreObjects/FbTienda.dart';

class FirebaseAdmin {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth dbAuth = FirebaseAuth.instance;

  // Devuelve el ID del usuario logeado
  String? getCurrentUserID(){
    return dbAuth.currentUser?.uid;
  }

  // Devuelve el usuario logeado
  User? getCurrentUser(){
    return dbAuth.currentUser;
  }

  String? getCurrentUserEmail(){
    return dbAuth.currentUser?.email;
  }

  // Cierra sesión
  void cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<String?> iniciarSesion(String email, String password) async {
    String? errorMessage;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(getCurrentUserID());
      await descargarFotoPerfil();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Correo no encontrado
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


  // Crea un usuario con un correo y una contraseña que se le pasa por parámetro
  Future<String?> registrarUsuario(String email, String password) async {
    String? errorMessage;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Contraseña débil
        errorMessage ='La contraseña proporcionada es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        // Correo electrónico ya en uso
        errorMessage = 'La cuenta ya existe para ese correo electrónico.';
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

  // Descarga la lista de componentes
  Future<List<FbComponente>> descargarComponentes() async {
    CollectionReference<FbComponente> ref = db.collection("Componentes").withConverter(
      fromFirestore: FbComponente.fromFirestore,
      toFirestore: (FbComponente post, _) => post.toFirestore(),
    );

    QuerySnapshot<FbComponente> querySnapshot = await ref.get();

    // Mapear los documentos a objetos FbPost y devolver una lista
    List<FbComponente> posts = querySnapshot.docs.map((doc) => doc.data()).toList();

    return posts;
  }

  Future<void> subirFotoPerfil(File fotoPerfil) async {
    final ref = FirebaseStorage.instance.ref().child("FotosPerfil/${getCurrentUserID()}/fotoPerfil.jpg");
    await ref.putFile(fotoPerfil);
  }

  // Método para cargar la foto de perfil
  Future<File?> descargarFotoPerfil() async {
    try {
      print(getCurrentUserID());
      final ref = FirebaseStorage.instance.ref().child("FotosPerfil/${getCurrentUserID()}/fotoPerfil.jpg");
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = "${appDocDir.path}/fotoPerfil.jpg";
      File imagePreview = File(filePath);

      await ref.writeToFile(imagePreview);

      return imagePreview;
    } catch (e) {
      // Manejar errores al cargar la foto de perfil
      print("Error al cargar la foto de perfil: $e");
      return null; // Devolver null en caso de error
    }
  }

  Future<QuerySnapshot<FbTienda>> cargarTiendas() async {
    try {
      CollectionReference<FbTienda> ref = db.collection("Tiendas")
          .withConverter(
        fromFirestore: FbTienda.fromFirestore,
        toFirestore: (FbTienda post, _) => post.toFirestore(),
      );
      return await ref.get();
    } catch (error) {
      print("Error al cargar tiendas: $error");
      throw error; // Re-lanzar el error para que pueda ser manejado fuera de la función
    }
  }
}