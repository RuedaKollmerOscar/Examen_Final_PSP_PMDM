import 'package:cloud_firestore/cloud_firestore.dart';

class FbGrafica {
  final String sNombre;
  final String sEnsamblador;
  final String sFabricante;
  final String sSerie;
  final int iCapacidad;
  final String sGeneracion;
  final double dPrecio;
  final String sUrlImg;

  FbGrafica({
    required this.sNombre,
    required this.sEnsamblador,
    required this.sFabricante,
    required this.sSerie,
    required this.iCapacidad,
    required this.sGeneracion,
    required this.dPrecio,
    required this.sUrlImg,
  });

  factory FbGrafica.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbGrafica(
      sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      sEnsamblador: data?['ensamblador'] != null ? data!['ensamblador'] : "xxxx",
      sFabricante: data?['fabricante'] != null ? data!['fabricante'] : "xxxx",
      sSerie: data?['serie'] != null ? data!['serie'] : "xxxx",
      iCapacidad: (data?['capacidad'] as int?) ?? 0,
      sGeneracion: data?['generacion'] != null ? data!['generacion'] : "xxxx",
      dPrecio: (data?['precio'] as num?)?.toDouble() ?? 0.0,
      sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (sEnsamblador != null) "ensamblador": sEnsamblador,
      if (sFabricante != null) "fabricante": sFabricante,
      if (sSerie != null) "serie": sSerie,
      if (iCapacidad != null) "capacidad": iCapacidad,
      if (sGeneracion != null) "generacion": sGeneracion,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg,
    };
  }
}
