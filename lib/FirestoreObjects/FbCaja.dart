import 'package:cloud_firestore/cloud_firestore.dart';

class FbCaja {

  final String sNombre;
  final String sColor;
  final double dPeso;
  final double dPrecio;
  final String sUrlImg;

  FbCaja ({
    required this.sNombre,
    required this.sColor,
    required this.dPeso,
    required this.dPrecio,
    required this.sUrlImg
  });

  factory FbCaja.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbCaja(
        sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
        sColor: data?['color'] != null ? data!['color'] : "xxxx",
        dPeso: (data?['peso'] as num?)?.toDouble() ?? -100.0,
        dPrecio: (data?['precio'] as num?)?.toDouble() ?? -100.0,
        sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx"
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre" : sNombre,
      if (sColor != null) "color" : sColor,
      if (dPeso != null) "peso" : dPeso,
      if (dPrecio != null) "precio" : dPrecio,
      if (sUrlImg != null) "urlImg" : sUrlImg
    };
  }
}