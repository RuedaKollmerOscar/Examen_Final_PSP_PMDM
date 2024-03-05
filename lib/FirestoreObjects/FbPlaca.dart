import 'package:cloud_firestore/cloud_firestore.dart';

class FbPlaca {
  final String sNombre;
  final String sFactorForma;
  final String sSocket;
  final String sChipset;
  final bool bWifi;
  final double dPrecio;
  final String sUrlImg;

  FbPlaca({
    required this.sNombre,
    required this.sFactorForma,
    required this.sSocket,
    required this.sChipset,
    required this.bWifi,
    required this.dPrecio,
    required this.sUrlImg,
  });

  factory FbPlaca.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbPlaca(
      sNombre: data?['nombre'] ?? 'xxxx',
      sFactorForma: data?['factorForma'] ?? 'xxxx',
      sSocket: data?['socket'] ?? 'xxxx',
      sChipset: data?['chipset'] ?? 'xxxx',
      bWifi: data?['wifi'] ?? false,
      dPrecio: (data?['precio'] ?? 0).toDouble(),
      sUrlImg: data?['urlImg'] ?? 'xxxx',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (sFactorForma != null) "factorForma": sFactorForma,
      if (sSocket != null) "socket": sSocket,
      if (sChipset != null) "chipset": sChipset,
      if (bWifi != null) "wifi": bWifi,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg,
    };
  }
}
