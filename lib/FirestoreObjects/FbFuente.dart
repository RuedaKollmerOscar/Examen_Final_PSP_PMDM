import 'package:cloud_firestore/cloud_firestore.dart';

class FbFuente {
  final String sNombre;
  final String sTipoCableado;
  final String sFormato;
  final int iPotencia;
  final String sCertificacion;
  final String sUrlImg;
  final double dPrecio;

  FbFuente({
    required this.sNombre,
    required this.sTipoCableado,
    required this.sFormato,
    required this.iPotencia,
    required this.sCertificacion,
    required this.sUrlImg,
    required this.dPrecio,
  });

  factory FbFuente.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbFuente(
      sNombre: data?['nombre'] != null ? data!['nombre'] : "xxxx",
      sTipoCableado: data?['tipoCableado'] != null ? data!['tipoCableado'] : "xxxx",
      sFormato: data?['formato'] != null ? data!['formato'] : "xxxx",
      iPotencia: (data?['potencia'] as num?)?.toInt() ?? -1,
      sCertificacion: data?['certificacion'] != null ? data!['certificacion'] : "xxxx",
      sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx",
      dPrecio: (data?['precio'] as num?)?.toDouble() ?? -1,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sNombre != null) "nombre": sNombre,
      if (sTipoCableado != null) "tipoCableado": sTipoCableado,
      if (sFormato != null) "formato": sFormato,
      if (iPotencia != null) "potencia": iPotencia,
      if (sCertificacion != null) "certificacion": sCertificacion,
      if (dPrecio != null) "precio": dPrecio,
      if (sUrlImg != null) "urlImg": sUrlImg
    };
  }
}