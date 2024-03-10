import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
      await dbAuth.createUserWithEmailAndPassword(
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

  // Cajas
  Future<String> subirFotoCaja(File fotoCaja, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Cajas/$nombreNube");
    await ref.putFile(fotoCaja, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirCaja(FbCaja cajaNueva) async {
    try {
      CollectionReference<FbCaja> ref = db.collection("Categorias/cajas/catalogo").withConverter(
        fromFirestore: FbCaja.fromFirestore,
        toFirestore: (FbCaja caja, _) => caja.toFirestore(),
      );
      await ref.add(cajaNueva);
      return null;
    } catch (error) {
      print("Error al subir la caja: $error");
      return "Error al subir la caja: $error";
    }
  }

  // Discos duros
  Future<String> subirFotoDiscoDuro(File fotoDiscoDuro, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/DiscosDuros/$nombreNube");
    await ref.putFile(fotoDiscoDuro, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirDiscoDuro(FbDiscoDuro discoDuroNuevo) async {
    try {
      CollectionReference<FbDiscoDuro> ref = db.collection("Categorias/discosduros/catalogo").withConverter(
        fromFirestore: FbDiscoDuro.fromFirestore,
        toFirestore: (FbDiscoDuro discoDuro, _) => discoDuro.toFirestore(),
      );
      await ref.add(discoDuroNuevo);
      return null;
    } catch (error) {
      print("Error al subir el disco duro: $error");
      return "Error al subir el disco duro: $error";
    }
  }

  // Disipadores
  Future<String> subirFotoDisipador(File fotoDisipador, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Disipadores/$nombreNube");
    await ref.putFile(fotoDisipador, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirDisipador(FbDisipador disipadorNuevo) async {
    try {
      CollectionReference<FbDisipador> ref = db.collection("Categorias/disipadores/catalogo").withConverter(
        fromFirestore: FbDisipador.fromFirestore,
        toFirestore: (FbDisipador disipador, _) => disipador.toFirestore(),
      );
      await ref.add(disipadorNuevo);
      return null;
    } catch (error) {
      print("Error al subir el disipador: $error");
      return "Error al subir el disipador: $error";
    }
  }

  // Fuentes de alimentacion
  Future<String> subirFotoFuente(File fotoFuente, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Fuentes_Alimentacion/$nombreNube");
    await ref.putFile(fotoFuente, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirFuente(FbFuente fuenteNueva) async {
    try {
      CollectionReference<FbFuente> ref = db.collection("Categorias/fuentesalimentacion/catalogo").withConverter(
        fromFirestore: FbFuente.fromFirestore,
        toFirestore: (FbFuente fuente, _) => fuente.toFirestore(),
      );
      await ref.add(fuenteNueva);
      return null;
    } catch (error) {
      print("Error al subir la fuente: $error");
      return "Error al subir la fuente: $error";
    }
  }

  // Placas base
  Future<String> subirFotoPlaca(File fotoPlaca, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Placas_Base/$nombreNube");
    await ref.putFile(fotoPlaca, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirPlaca(FbPlaca placaBaseNueva) async {
    try {
      CollectionReference<FbPlaca> ref = db.collection("Categorias/placasbase/catalogo").withConverter(
        fromFirestore: FbPlaca.fromFirestore,
        toFirestore: (FbPlaca placa, _) => placa.toFirestore(),
      );
      await ref.add(placaBaseNueva);
      return null;
    } catch (error) {
      print("Error al subir la placa base: $error");
      return "Error al subir la placa base: $error";
    }
  }

  // Procesadores
  Future<String> subirFotoProcesador(File fotoProcesador, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Procesadores/$nombreNube");
    await ref.putFile(fotoProcesador, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirProcesador(FbProcesador procesadorNuevo) async {
    try {
      CollectionReference<FbProcesador> ref = db.collection("Categorias/procesadores/catalogo").withConverter(
        fromFirestore: FbProcesador.fromFirestore,
        toFirestore: (FbProcesador procesador, _) => procesador.toFirestore(),
      );
      await ref.add(procesadorNuevo);
      return null;
    } catch (error) {
      print("Error al subir el procesador: $error");
      return "Error al subir el procesador: $error";
    }
  }

  // Memorias RAM
  Future<String> subirFotoRAM(File fotoRAM, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/RAMs/$nombreNube");
    await ref.putFile(fotoRAM, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirRAM(FbRAM ramNueva) async {
    try {
      CollectionReference<FbRAM> ref = db.collection("Categorias/rams/catalogo").withConverter(
        fromFirestore: FbRAM.fromFirestore,
        toFirestore: (FbRAM ram, _) => ram.toFirestore(),
      );
      await ref.add(ramNueva);
      return null;
    } catch (error) {
      print("Error al subir la memoria RAM: $error");
      return "Error al subir la memoria RAM: $error";
    }
  }

  // Tarjetas graficas
  Future<String> subirFotoGrafica(File fotoGrafica, String nombreNube) async {
    final ref = FirebaseStorage.instance.ref().child("FotosComponentes/Tarjetas_graficas/$nombreNube");
    await ref.putFile(fotoGrafica, SettableMetadata(contentType: "image/jpeg"));
    return await ref.getDownloadURL();
  }

  Future<String?> subirGrafica(FbGrafica graficaNueva) async {
    try {
      CollectionReference<FbGrafica> ref = db.collection("Categorias/tarjetasgraficas/catalogo").withConverter(
        fromFirestore: FbGrafica.fromFirestore,
        toFirestore: (FbGrafica grafica, _) => grafica.toFirestore(),
      );
      await ref.add(graficaNueva);
      return null;
    } catch (error) {
      print("Error al subir la tarjeta gráfica: $error");
      return "Error al subir la tarjeta gráfica: $error";
    }
  }


  // Metodos para editar componentes


  Future<String?> editarCaja(String idCaja, String nombre, String color, double peso, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/cajas/catalogo").doc(idCaja).update({
        "nombre": nombre,
        "color": color,
        "peso": peso,
        "precio": precio,
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarDiscoDuro(String idDiscoDuro, String nombre, String tipo, int almacenamiento, int lectura, int escritura, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/discosduros/catalogo").doc(idDiscoDuro).update({
        "nombre": nombre,
        "tipo": tipo,
        "almacenamiento": almacenamiento,
        "lectura": lectura,
        "escritura": escritura,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarDisipador(String idDisipador, String nombre, String color, String material, int minima, int maxima, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/disipadores/catalogo").doc(idDisipador).update({
        "nombre": nombre,
        "color": color,
        "material": material,
        "velocidadRotacionMinima": minima,
        "velocidadRotacionMaxima": maxima,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarFuente(String idFuente, String nombre, String cableado, String formato, int potencia, String certificacion, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/fuentesalimentacion/catalogo").doc(idFuente).update({
        "nombre": nombre,
        "tipoCableado": cableado,
        "formato": formato,
        "potencia": potencia,
        "certificacion": certificacion,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarPlaca(String idPlaca, String nombre, String formato, String socket, String chipset, bool wifi, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/placasbase/catalogo").doc(idPlaca).update({
        "nombre": nombre,
        "factorForma": formato,
        "socket": socket,
        "chipset": chipset,
        "wifi": wifi,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarProcesador(String idProcesador, String nombre, String marca, String modelo, int nucleos, int hilos, double velocidadBase, bool overclock, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/procesadores/catalogo").doc(idProcesador).update({
        "nombre": nombre,
        "marca": marca,
        "modelo": modelo,
        "nucleos": nucleos,
        "hilos": hilos,
        "velocidadBase": velocidadBase,
        "overclock": overclock,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarRAM(String idRAM, String nombre, int capacidad, int modulos, int velocidad, int generacion, bool rgb, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/rams/catalogo").doc(idRAM).update({
        "nombre": nombre,
        "capacidad": capacidad,
        "modulos": modulos,
        "velocidad": velocidad,
        "generacion": generacion,
        "rgb": rgb,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
  }

  Future<String?> editarGrafica(String idGrafica, String nombre, String ensamblador, String fabricante, String serie, int capacidad, int generacion, double precio) async {
    try {
      await FirebaseFirestore.instance.collection("Categorias/tarjetasgraficas/catalogo").doc(idGrafica).update({
        "nombre": nombre,
        "ensamblador": ensamblador,
        "fabricante": fabricante,
        "serie": serie,
        "capacidad": capacidad,
        "generacion": generacion,
        "precio": precio
      });
      return null;
    } catch (e) {
      print("Error al actualizar el componente: $e");
      return "Error al actualizar el componente";
    }
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


  // Metodo para eliminar componentes

  Future<String> eliminarComponente(String categoria, String idComponente) async {
    try {
      await db.collection("Categorias/$categoria/catalogo").doc(idComponente).delete();
      return "Componente eliminado correctamente";
    } catch (e) {
      return "Error al eliminar el componente: $e";
    }
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

  Future<FbCaja?> descargarCajaRandom() async {
    try {
      CollectionReference<FbCaja> ref = db.collection("Categorias/cajas/catalogo").withConverter(
        fromFirestore: FbCaja.fromFirestore,
        toFirestore: (FbCaja componente, _) => componente.toFirestore(),
      );

      // Obten la lista completa de cajas
      QuerySnapshot<FbCaja> querySnapshot = await ref.get();
      List<FbCaja> cajas = querySnapshot.docs.map((doc) => doc.data()).toList();

      // Verifica si hay cajas disponibles
      if (cajas.isEmpty) {
        return null;
      }

      // Selecciona aleatoriamente una caja
      Random random = Random();
      int index = random.nextInt(cajas.length);
      FbCaja cajaAleatoria = cajas[index];

      return cajaAleatoria;
    } catch (e) {
      print("Error al descargar caja aleatoria: $e");
      return null;
    }
  }

  Future<FbDiscoDuro?> descargarDiscoDuroRandom() async {
    try {
      CollectionReference<FbDiscoDuro> ref = db.collection("Categorias/discosduros/catalogo").withConverter(
        fromFirestore: FbDiscoDuro.fromFirestore,
        toFirestore: (FbDiscoDuro componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbDiscoDuro> querySnapshot = await ref.get();
      List<FbDiscoDuro> discosDuros = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (discosDuros.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(discosDuros.length);
      FbDiscoDuro discoDuroAleatorio = discosDuros[index];

      return discoDuroAleatorio;
    } catch (e) {
      print("Error al descargar disco duro aleatorio: $e");
      return null;
    }
  }

  Future<FbDisipador?> descargarDisipadorRandom() async {
    try {
      CollectionReference<FbDisipador> ref = db.collection("Categorias/disipadores/catalogo").withConverter(
        fromFirestore: FbDisipador.fromFirestore,
        toFirestore: (FbDisipador componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbDisipador> querySnapshot = await ref.get();
      List<FbDisipador> disipadores = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (disipadores.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(disipadores.length);
      FbDisipador disipadorAleatorio = disipadores[index];

      return disipadorAleatorio;
    } catch (e) {
      print("Error al descargar disipador aleatorio: $e");
      return null;
    }
  }

  Future<FbFuente?> descargarFuenteRandom() async {
    try {
      CollectionReference<FbFuente> ref = db.collection("Categorias/fuentesalimentacion/catalogo").withConverter(
        fromFirestore: FbFuente.fromFirestore,
        toFirestore: (FbFuente componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbFuente> querySnapshot = await ref.get();
      List<FbFuente> fuentes = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (fuentes.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(fuentes.length);
      FbFuente fuenteAleatoria = fuentes[index];

      return fuenteAleatoria;
    } catch (e) {
      print("Error al descargar fuente aleatoria: $e");
      return null;
    }
  }

  Future<FbPlaca?> descargarPlacaRandom() async {
    try {
      CollectionReference<FbPlaca> ref = db.collection("Categorias/placasbase/catalogo").withConverter(
        fromFirestore: FbPlaca.fromFirestore,
        toFirestore: (FbPlaca componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbPlaca> querySnapshot = await ref.get();
      List<FbPlaca> placas = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (placas.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(placas.length);
      FbPlaca placaAleatoria = placas[index];

      return placaAleatoria;
    } catch (e) {
      print("Error al descargar placa aleatoria: $e");
      return null;
    }
  }

  Future<FbProcesador?> descargarProcesadorRandom() async {
    try {
      CollectionReference<FbProcesador> ref = db.collection("Categorias/procesadores/catalogo").withConverter(
        fromFirestore: FbProcesador.fromFirestore,
        toFirestore: (FbProcesador componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbProcesador> querySnapshot = await ref.get();
      List<FbProcesador> procesadores = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (procesadores.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(procesadores.length);
      FbProcesador procesadorAleatorio = procesadores[index];

      return procesadorAleatorio;
    } catch (e) {
      print("Error al descargar procesador aleatorio: $e");
      return null;
    }
  }

  Future<FbRAM?> descargarRAMRandom() async {
    try {
      CollectionReference<FbRAM> ref = db.collection("Categorias/rams/catalogo").withConverter(
        fromFirestore: FbRAM.fromFirestore,
        toFirestore: (FbRAM componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbRAM> querySnapshot = await ref.get();
      List<FbRAM> rams = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (rams.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(rams.length);
      FbRAM ramAleatoria = rams[index];

      return ramAleatoria;
    } catch (e) {
      print("Error al descargar RAM aleatoria: $e");
      return null;
    }
  }

  Future<FbGrafica?> descargarGraficaRandom() async {
    try {
      CollectionReference<FbGrafica> ref = db.collection("Categorias/tarjetasgraficas/catalogo").withConverter(
        fromFirestore: FbGrafica.fromFirestore,
        toFirestore: (FbGrafica componente, _) => componente.toFirestore(),
      );

      QuerySnapshot<FbGrafica> querySnapshot = await ref.get();
      List<FbGrafica> graficas = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (graficas.isEmpty) {
        return null;
      }

      Random random = Random();
      int index = random.nextInt(graficas.length);
      FbGrafica graficaAleatoria = graficas[index];

      return graficaAleatoria;
    } catch (e) {
      print("Error al descargar tarjeta gráfica aleatoria: $e");
      return null;
    }
  }
}