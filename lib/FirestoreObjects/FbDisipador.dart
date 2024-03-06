import 'package:cloud_firestore/cloud_firestore.dart';

class FbDisipador {
  final String sNombre;
  final String sColor;
  final String sMaterial;
  final int iVelocidadRotacionMinima;
  final int iVelocidadRotacionMaxima;
  final double dPrecio;
  final String sUrlImg;

  FbDisipador({
    required this.sNombre,
    required this.sColor,
    required this.sMaterial,
    required this.iVelocidadRotacionMinima,
    required this.iVelocidadRotacionMaxima,
    required this.dPrecio,
    required this.sUrlImg
  });

  factory FbDisipador.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbDisipador(
      sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      sColor: data?['color'] != null ? data!['color'] : "xxxx",
      sMaterial: data?['material'] != null ? data!['material'] : "xxxx",
      iVelocidadRotacionMinima: (data?['velocidadRotacionMinima'] as num?)?.toInt() ?? -1,
      iVelocidadRotacionMaxima: (data?['velocidadRotacionMaxima'] as num?)?.toInt() ?? -1,
      dPrecio: (data?['precio'] as num?)?.toDouble() ?? -1,
      sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (sColor != null) "color": sColor,
      if (sMaterial != null) "material": sMaterial,
      if (iVelocidadRotacionMinima != null) "velocidadRotacionMinima": iVelocidadRotacionMinima,
      if (iVelocidadRotacionMaxima != null) "velocidadRotacionMaxima": iVelocidadRotacionMaxima,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg,
    };
  }
}
