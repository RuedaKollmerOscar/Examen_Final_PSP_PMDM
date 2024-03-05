import 'package:cloud_firestore/cloud_firestore.dart';

class FbTienda {

  final String name;
  final String loc;
  GeoPoint geoloc;

  FbTienda ({
    required this.name,
    required this.loc,
    required this.geoloc
  });

  factory FbTienda.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbTienda(
      name: data?['name'] != null ? data!['name'] : "xxxx",
      loc: data?['loc'] != null ? data!['loc'] : "xxxx",
      geoloc: data?['geoloc'] != null ? data!['geoloc'] : GeoPoint(0, 0)
    );

  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name" : name,
      if (loc != null) "loc" : loc,
      if (geoloc != null) "geoloc": geoloc,
    };
  }
}
