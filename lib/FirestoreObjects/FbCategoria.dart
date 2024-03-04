import 'package:cloud_firestore/cloud_firestore.dart';

class FbCategoria {

  final String name;
  final String urlImg;

  FbCategoria ({
    required this.name,
    required this.urlImg
  });

  factory FbCategoria.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbCategoria(
        name: data?['name'] != null ? data!['name'] : "xxxx",
        urlImg: data?['urlImg'] != null ? data!['urlImg'] : "xxxx"
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name" : name,
      if (urlImg != null) "urlImg" : urlImg
    };
  }
}
