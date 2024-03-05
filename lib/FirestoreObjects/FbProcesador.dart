import 'package:cloud_firestore/cloud_firestore.dart';

class FbProcesador {
  final String sNombre;
  final String sMarca;
  final String sModelo;
  final int iNucleos;
  final int iHilos;
  final double dVelocidadBase;
  final bool bOverclock;
  final double dPrecio;
  final String sUrlImg;

  FbProcesador({
    required this.sNombre,
    required this.sMarca,
    required this.sModelo,
    required this.iNucleos,
    required this.iHilos,
    required this.dVelocidadBase,
    required this.bOverclock,
    required this.dPrecio,
    required this.sUrlImg,
  });

  factory FbProcesador.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbProcesador(
      sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      sMarca: data?['marca'] != null ? data!['marca'] : "xxxx",
      sModelo: data?['modelo'] != null ? data!['modelo'] : "xxxx",
      iNucleos: (data?['nucleos'] as int?) ?? 0,
      iHilos: (data?['hilos'] as int?) ?? 0,
      dVelocidadBase: (data?['velocidadBase'] as num?)?.toDouble() ?? 0.0,
      bOverclock: data?['overclock'] ?? false,
      dPrecio: (data?['precio'] as num?)?.toDouble() ?? 0.0,
      sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (sMarca != null) "marca": sMarca,
      if (sModelo != null) "modelo": sModelo,
      if (iNucleos != null) "nucleos": iNucleos,
      if (iHilos != null) "hilos": iHilos,
      if (dVelocidadBase != null) "velocidadBase": dVelocidadBase,
      if (bOverclock != null) "overclock": bOverclock,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg,
    };
  }
}
