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

  // Metodos para subir componentes


  // Tarjetas graficas
  Future<String> subirFotoGrafica(File fotoGrafica, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Tarjetas_graficas/$nombreNube");
    await ref.putFile(fotoGrafica, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirGrafica(FbGrafica graficaNueva) async {
    CollectionReference<FbGrafica> ref = db.collection("Categorias/tarjetasgraficas/catalogo").withConverter(
      fromFirestore: FbGrafica.fromFirestore,
      toFirestore: (FbGrafica grafica, _) => grafica.toFirestore(),
    );
    await ref.add(graficaNueva);
  }


  // Memorias RAM
  Future<String> subirFotoRAM(File fotoRAM, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/RAMs/$nombreNube");
    await ref.putFile(fotoRAM, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirRAM(FbRAM ramNueva) async {
    CollectionReference<FbRAM> ref = db.collection("Categorias/rams/catalogo").withConverter(
      fromFirestore: FbRAM.fromFirestore,
      toFirestore: (FbRAM ram, _) => ram.toFirestore(),
    );
    await ref.add(ramNueva);
  }


  // Procesadores
  Future<String> subirFotoProcesador(File fotoProcesador, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Procesadores/$nombreNube");
    await ref.putFile(fotoProcesador, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirProcesador(FbProcesador procesadorNuevo) async {
    CollectionReference<FbProcesador> ref = db.collection("Categorias/procesadores/catalogo").withConverter(
        fromFirestore: FbProcesador.fromFirestore,
        toFirestore: (FbProcesador procesador, _) => procesador.toFirestore(),
    );
    await ref.add(procesadorNuevo);
  }


  // Placas base
  Future<String> subirFotoPlaca(File fotoPlaca, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Placas_Base/$nombreNube");
    await ref.putFile(fotoPlaca, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }


  Future<void> subirPlaca(FbPlaca placaBaseNueva) async {
    CollectionReference<FbPlaca> ref = db.collection("Categorias/placasbase/catalogo").withConverter(
      fromFirestore: FbPlaca.fromFirestore,
      toFirestore: (FbPlaca placa, _) => placa.toFirestore(),
    );
    await ref.add(placaBaseNueva);
  }


  // Fuentes de alimentacion
  Future<String> subirFotoFuente(File fotoFuente, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Fuentes_Alimentacion/$nombreNube");
    await ref.putFile(fotoFuente, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirFuente(FbFuente fuenteNueva) async {
    CollectionReference<FbFuente> ref = db.collection("Categorias/fuentesalimentacion/catalogo").withConverter(
      fromFirestore: FbFuente.fromFirestore,
      toFirestore: (FbFuente fuente, _) => fuente.toFirestore(),
    );
    await ref.add(fuenteNueva);
  }


  // Disipadores
  Future<String> subirFotoDisipador(File fotoDisipador, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Disipadores/$nombreNube");
    await ref.putFile(fotoDisipador, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirDisipador(FbDisipador disipadorNuevo) async {
    CollectionReference<FbDisipador> ref = db.collection("Categorias/disipadores/catalogo").withConverter(
      fromFirestore: FbDisipador.fromFirestore,
      toFirestore: (FbDisipador disipador, _) => disipador.toFirestore(),
    );
    await ref.add(disipadorNuevo);
  }


  // Discos duros
  Future<String> subirFotoDiscoDuro(File fotoDiscoDuro, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/DiscosDuros/$nombreNube");
    await ref.putFile(fotoDiscoDuro, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirDiscoDuro(FbDiscoDuro discoDuroNuevo) async {
    CollectionReference<FbDiscoDuro> ref = db.collection("Categorias/discosduros/catalogo").withConverter(
      fromFirestore: FbDiscoDuro.fromFirestore,
      toFirestore: (FbDiscoDuro discoDuro, _) => discoDuro.toFirestore(),
    );
    await ref.add(discoDuroNuevo);
  }


  // Cajas
  Future<String> subirFotoCaja(File fotoCaja, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Cajas/$nombreNube");
    await ref.putFile(fotoCaja, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<void> subirCaja(FbCaja cajaNueva) async {
    CollectionReference<FbCaja> ref = db.collection("Categorias/cajas/catalogo").withConverter(
      fromFirestore: FbCaja.fromFirestore,
      toFirestore: (FbCaja caja, _) => caja.toFirestore(),
    );
    await ref.add(cajaNueva);
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

  // Descarga cajas y escucha cambios
  void descargarCajas(void Function(QuerySnapshot<FbCaja>) datosDescargados) {
    CollectionReference<FbCaja> ref = FirebaseFirestore.instance.collection("Categorias/cajas/catalogo")
        .withConverter(fromFirestore: FbCaja.fromFirestore, toFirestore: (FbCaja caja, _) => caja.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga discos duros y escucha cambios
  void descargarDiscosDuros(void Function(QuerySnapshot<FbDiscoDuro>) datosDescargados) {
    CollectionReference<FbDiscoDuro> ref = FirebaseFirestore.instance.collection("Categorias/discosduros/catalogo")
        .withConverter(fromFirestore: FbDiscoDuro.fromFirestore, toFirestore: (FbDiscoDuro discoDuro, _) => discoDuro.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga disipadores y escucha cambios
  void descargarDisipadores(void Function(QuerySnapshot<FbDisipador>) datosDescargados) {
    CollectionReference<FbDisipador> ref = FirebaseFirestore.instance.collection("Categorias/disipadores/catalogo")
        .withConverter(fromFirestore: FbDisipador.fromFirestore, toFirestore: (FbDisipador disipador, _) => disipador.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga fuentes de alimentacion y escucha cambios
  void descargarFuentes(void Function(QuerySnapshot<FbFuente>) datosDescargados) {
    CollectionReference<FbFuente> ref = FirebaseFirestore.instance.collection("Categorias/fuentesalimentacion/catalogo")
        .withConverter(fromFirestore: FbFuente.fromFirestore, toFirestore: (FbFuente fuente, _) => fuente.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga placas base y escucha cambios
  void descargarPlacas(void Function(QuerySnapshot<FbPlaca>) datosDescargados) {
    CollectionReference<FbPlaca> ref = FirebaseFirestore.instance.collection("Categorias/placasbase/catalogo")
        .withConverter(fromFirestore: FbPlaca.fromFirestore, toFirestore: (FbPlaca placa, _) => placa.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga procesadores y escucha cambios
  void descargarProcesadores(void Function(QuerySnapshot<FbProcesador>) datosDescargados) {
    CollectionReference<FbProcesador> ref = FirebaseFirestore.instance.collection("Categorias/procesadores/catalogo")
        .withConverter(fromFirestore: FbProcesador.fromFirestore, toFirestore: (FbProcesador procesador, _) => procesador.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga memorias RAM y escucha cambios
  void descargarRAM(void Function(QuerySnapshot<FbRAM>) datosDescargados) {
    CollectionReference<FbRAM> ref = FirebaseFirestore.instance.collection("Categorias/rams/catalogo")
        .withConverter(fromFirestore: FbRAM.fromFirestore, toFirestore: (FbRAM rams, _) => rams.toFirestore());

    ref.snapshots().listen(datosDescargados);
  }

  // Descarga tarjetas graficas y escucha cambios
  void descargarGraficas(void Function(QuerySnapshot<FbGrafica>) datosDescargados) {
    CollectionReference<FbGrafica> ref = FirebaseFirestore.instance.collection("Categorias/tarjetasgraficas/catalogo")
        .withConverter(fromFirestore: FbGrafica.fromFirestore, toFirestore: (FbGrafica grafica, _) => grafica.toFirestore());

    ref.snapshots().listen(datosDescargados);
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