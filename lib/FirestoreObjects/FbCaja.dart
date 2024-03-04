import 'package:cloud_firestore/cloud_firestore.dart';

class FbCaja {

  final String nombre;
  final String color;
  final double peso;
  final double precio;
  final String urlImg;

  FbCaja ({
    required this.nombre,
    required this.color,
    required this.peso,
    required this.precio,
    required this.urlImg
  });

  factory FbCaja.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbCaja(
        nombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
        color: data?['color'] != null ? data!['color'] : "xxxx",
        peso: (data?['peso'] as num?)?.toDouble() ?? -100.0,
        precio: (data?['precio'] as num?)?.toDouble() ?? -100.0,
        urlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx"
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "name" : nombre,
      if (color != null) "name" : color,
      if (peso != null) "name" : peso,
      if (precio != null) "name" : precio,
      if (urlImg != null) "urlImg" : urlImg
    };
  }
}
