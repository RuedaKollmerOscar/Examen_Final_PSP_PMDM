import 'package:cloud_firestore/cloud_firestore.dart';

class FbDiscoDuro {
  final String sNombre;
  final String sTipo;
  final int iEscritura;
  final int iLectura;
  final double dPrecio;
  final String sUrlImg;

  FbDiscoDuro({
    required this.sNombre,
    required this.sTipo,
    required this.iEscritura,
    required this.iLectura,
    required this.dPrecio,
    required this.sUrlImg,
  });

  factory FbDiscoDuro.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbDiscoDuro(
      sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      sTipo: data?['tipo'] != null ? data!['tipo'] : "xxxx",
      iEscritura: (data?['escritura'] as int?) ?? -1,
      iLectura: (data?['lectura'] as int?) ?? -1,
      dPrecio: (data?['precio'] as num?)?.toDouble() ?? -1,
      sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (sTipo != null) "tipo": sTipo,
      if (iEscritura != null) "escritura": iEscritura,
      if (iLectura != null) "lectura": iLectura,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg,
    };
  }
}