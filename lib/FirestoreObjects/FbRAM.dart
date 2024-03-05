import 'package:cloud_firestore/cloud_firestore.dart';

class FbRAM {
  final String sNombre;
  final int iCapacidad;
  final int iModulos;
  final int iVelocidad;
  final String sGeneracion;
  final bool bRGB;
  final double dPrecio;
  final String sUrlImg;

  FbRAM({
    required this.sNombre,
    required this.iCapacidad,
    required this.iModulos,
    required this.iVelocidad,
    required this.sGeneracion,
    required this.bRGB,
    required this.dPrecio,
    required this.sUrlImg,
  });

  factory FbRAM.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbRAM(
      sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      iCapacidad: (data?['capacidad'] as int?) ?? 0,
      iModulos: (data?['modulos'] as int?) ?? 0,
      iVelocidad: (data?['velocidad'] as int?) ?? 0,
      sGeneracion: data?['generacion'] != null ? data!['generacion'] : "xxxx",
      bRGB: data?['rgb'] ?? false,
      dPrecio: (data?['precio'] as num?)?.toDouble() ?? 0.0,
      sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (iCapacidad != null) "capacidad": iCapacidad,
      if (iModulos != null) "modulos": iModulos,
      if (iVelocidad != null) "velocidad": iVelocidad,
      if (sGeneracion != null) "generacion": sGeneracion,
      if (bRGB != null) "rgb": bRGB,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg,
    };
  }
}
