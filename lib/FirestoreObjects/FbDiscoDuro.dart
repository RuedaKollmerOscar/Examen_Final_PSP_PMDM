import 'package:cloud_firestore/cloud_firestore.dart';

class FbDiscoDuro {
  final String nombre;
  final String tipo;
  final int escritura;
  final int lectura;
  final double precio;
  final String urlImg;

  FbDiscoDuro({
    required this.nombre,
    required this.tipo,
    required this.escritura,
    required this.lectura,
    required this.precio,
    required this.urlImg,
  });

  factory FbDiscoDuro.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbDiscoDuro(
      nombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      tipo: data?['tipo'] != null ? data!['tipo'] : "xxxx",
      escritura: (data?['escritura'] as int?) ?? -1,
      lectura: (data?['lectura'] as int?) ?? -1,
      precio: (data?['precio'] as num?)?.toDouble() ?? -1,
      urlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (tipo != null) "tipo": tipo,
      if (escritura != null) "escritura": escritura,
      if (lectura != null) "lectura": lectura,
      if (precio != null) "precio": precio,
      if (urlImg != null) "urlImg": urlImg,
    };
  }
}
