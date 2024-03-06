import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import 'package:techshop/FirestoreObjects/FbComponente.dart';
import 'package:techshop/FirestoreObjects/FbDiscoDuro.dart';
import 'package:techshop/FirestoreObjects/FbDisipador.dart';
import 'package:techshop/FirestoreObjects/FbFuente.dart';
import 'package:techshop/FirestoreObjects/FbGrafica.dart';
import 'package:techshop/FirestoreObjects/FbPlaca.dart';
import 'package:techshop/FirestoreObjects/FbProcesador.dart';
import 'package:techshop/FirestoreObjects/FbRAM.dart';

import '../FirestoreObjects/FbCaja.dart';
import '../FirestoreObjects/FbTienda.dart';

class FirebaseAdmin {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth dbAuth = FirebaseAuth.instance;

  // Atributos de usuario

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

  // Metodos de autenticacion

  // Cierra sesion
  void cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
  }

  // Inica sesion
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

  Future<void> subirFotoPerfil(File fotoPerfil) async {
    final ref = FirebaseStorage.instance.ref().child("FotosPerfil/${getCurrentUserID()}/fotoPerfil.jpg");
    await ref.putFile(fotoPerfil);
  }

  Future<String> subirFotoFuente(File fotoFuente, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Fuentes_Alimentacion/$nombreNube");
    await ref.putFile(fotoFuente, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirFuente(FbFuente fuenteNueva) async {
    CollectionReference<FbFuente> postsRef = db.collection("Categorias/fuentesalimentacion/catalogo").withConverter(
      fromFirestore: FbFuente.fromFirestore,
      toFirestore: (FbFuente fuente, _) => fuente.toFirestore(),
    );
    await postsRef.add(fuenteNueva);
  }

  Future<String> subirFotoDisipador(File fotoDisipador, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Disipadores/$nombreNube");
    await ref.putFile(fotoDisipador, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirDisipador(FbDisipador disipadorNuevo) async {
    CollectionReference<FbDisipador> postsRef = db.collection("Categorias/disipadores/catalogo").withConverter(
      fromFirestore: FbDisipador.fromFirestore,
      toFirestore: (FbDisipador disipador, _) => disipador.toFirestore(),
    );
    await postsRef.add(disipadorNuevo);
  }

  Future<String> subirFotoDiscoDuro(File fotoDiscoDuro, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Disipadores/$nombreNube");
    await ref.putFile(fotoDiscoDuro, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirDiscoDuro(FbDiscoDuro discoDuroNuevo) async {
    CollectionReference<FbDiscoDuro> postsRef = db.collection("Categorias/discosduros/catalogo").withConverter(
      fromFirestore: FbDiscoDuro.fromFirestore,
      toFirestore: (FbDiscoDuro discoDuro, _) => discoDuro.toFirestore(),
    );
    await postsRef.add(discoDuroNuevo);
  }

  Future<String> subirFotoCaja(File fotoCaja, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Cajas/$nombreNube");
    await ref.putFile(fotoCaja, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirCaja(FbCaja cajaNueva) async {
    CollectionReference<FbCaja> postsRef = db.collection("Categorias/cajas/catalogo").withConverter(
      fromFirestore: FbCaja.fromFirestore,
      toFirestore: (FbCaja caja, _) => caja.toFirestore(),
    );
    await postsRef.add(cajaNueva);
  }

  // Metodos para descargar colecciones

  // Descarga la lista de componentes
  Future<List<FbComponente>> descargarComponentes() async {
    CollectionReference<FbComponente> ref = db.collection("Componentes").withConverter(
      fromFirestore: FbComponente.fromFirestore,
      toFirestore: (FbComponente componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbComponente> querySnapshot = await ref.get();

    List<FbComponente> componentes = querySnapshot.docs.map((doc) => doc.data()).toList();

    return componentes;
  }

  // Descarga la lista de categorias
  Future<List<FbCategoria>> descargarCategorias() async {
    CollectionReference<FbCategoria> ref = db.collection("Categorias").withConverter(
      fromFirestore: FbCategoria.fromFirestore,
      toFirestore: (FbCategoria categoria, _) => categoria.toFirestore(),
    );

    QuerySnapshot<FbCategoria> querySnapshot = await ref.get();

    List<FbCategoria> categorias = querySnapshot.docs.map((doc) => doc.data()).toList();

    return categorias;
  }

  // Descarga la lista de cajas
  Future<List<FbCaja>> descargarCajas() async {
    CollectionReference<FbCaja> ref = db.collection("Categorias/cajas/catalogo").withConverter(
      fromFirestore: FbCaja.fromFirestore,
      toFirestore: (FbCaja componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbCaja> querySnapshot = await ref.get();

    List<FbCaja> cajas = querySnapshot.docs.map((doc) => doc.data()).toList();

    return cajas;
  }

  // Descarga la lista de discos duros
  Future<List<FbDiscoDuro>> descargarDiscosDuros() async {
    CollectionReference<FbDiscoDuro> ref = db.collection("Categorias/discosduros/catalogo").withConverter(
      fromFirestore: FbDiscoDuro.fromFirestore,
      toFirestore: (FbDiscoDuro componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbDiscoDuro> querySnapshot = await ref.get();

    List<FbDiscoDuro> discosDuros = querySnapshot.docs.map((doc) => doc.data()).toList();

    return discosDuros;
  }

  // Descarga la lista de disipadores
  Future<List<FbDisipador>> descargarDisipadores() async {
    CollectionReference<FbDisipador> ref = db.collection("Categorias/disipadores/catalogo").withConverter(
      fromFirestore: FbDisipador.fromFirestore,
      toFirestore: (FbDisipador componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbDisipador> querySnapshot = await ref.get();

    List<FbDisipador> disipadores = querySnapshot.docs.map((doc) => doc.data()).toList();

    return disipadores;
  }

  // Descarga la lista de placas base
  Future<List<FbPlaca>> descargarPlacas() async {
    CollectionReference<FbPlaca> ref = db.collection("Categorias/placasbase/catalogo").withConverter(
      fromFirestore: FbPlaca.fromFirestore,
      toFirestore: (FbPlaca componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbPlaca> querySnapshot = await ref.get();

    List<FbPlaca> placas = querySnapshot.docs.map((doc) => doc.data()).toList();

    return placas;
  }

  // Descarga la lista de disipadores
  Future<List<FbFuente>> descargarFuentes() async {
    CollectionReference<FbFuente> ref = db.collection("Categorias/fuentesalimentacion/catalogo").withConverter(
      fromFirestore: FbFuente.fromFirestore,
      toFirestore: (FbFuente componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbFuente> querySnapshot = await ref.get();

    List<FbFuente> fuentes = querySnapshot.docs.map((doc) => doc.data()).toList();

    return fuentes;
  }

  // Descarga la lista de procesadores
  Future<List<FbProcesador>> descargarProcesadores() async {
    CollectionReference<FbProcesador> ref = db.collection("Categorias/procesadores/catalogo").withConverter(
      fromFirestore: FbProcesador.fromFirestore,
      toFirestore: (FbProcesador componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbProcesador> querySnapshot = await ref.get();

    List<FbProcesador> procesadores = querySnapshot.docs.map((doc) => doc.data()).toList();

    return procesadores;
  }

  // Descarga la lista de memorias RAM
  Future<List<FbRAM>> descargarRAMs() async {
    CollectionReference<FbRAM> ref = db.collection("Categorias/rams/catalogo").withConverter(
      fromFirestore: FbRAM.fromFirestore,
      toFirestore: (FbRAM componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbRAM> querySnapshot = await ref.get();

    List<FbRAM> rams = querySnapshot.docs.map((doc) => doc.data()).toList();

    return rams;
  }

  // Descarga la lista de tarjetas graficas
  Future<List<FbGrafica>> descargarGraficas() async {
    CollectionReference<FbGrafica> ref = db.collection("Categorias/tarjetasgraficas/catalogo").withConverter(
      fromFirestore: FbGrafica.fromFirestore,
      toFirestore: (FbGrafica componente, _) => componente.toFirestore(),
    );

    QuerySnapshot<FbGrafica> querySnapshot = await ref.get();

    List<FbGrafica> graficas = querySnapshot.docs.map((doc) => doc.data()).toList();

    return graficas;
  }

  // Descarga la coleccion y la devuelve (no devuelve un list)
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