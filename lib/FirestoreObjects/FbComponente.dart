import 'package:cloud_firestore/cloud_firestore.dart';

class FbComponente {
  final String name;
  final double price;
  final String urlImg;

  FbComponente({
    required this.name,
    required this.price,
    required this.urlImg
  });

  factory FbComponente.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return FbComponente(
      name: data?['name'] ?? "xxxx",
      price: (data?['price'] as num?)?.toDouble() ?? -100.0,
      urlImg: data?['urlImg'] != null ? data!['urlImg'] : ""
    );
  }

  Map<String, dynamic> toFirestore() => {
    if (name != null) "name": name,
    if (price != null) "price": price,
    if (urlImg != null) "urlImg": urlImg
  };
}