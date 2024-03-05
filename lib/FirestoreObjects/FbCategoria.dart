import 'package:cloud_firestore/cloud_firestore.dart';

class FbCategoria {

  final String sName;
  final String sUrlImg;

  FbCategoria ({
    required this.sName,
    required this.sUrlImg
  });

  factory FbCategoria.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbCategoria(
        sName: data?['name'] != null ? data!['name'] : "xxxx",
        sUrlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx"
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (sName != null) "name" : sName,
      if (sUrlImg != null) "urlImg" : sUrlImg
    };
  }
}