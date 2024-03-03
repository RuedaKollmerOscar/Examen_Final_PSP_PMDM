import 'package:techshop/FirestoreObjects/FbComponente.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  late FbComponente componenteSeleccionado;

  FirebaseAdmin fbadmin=FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();

  void initDataHolder() {}

  DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }
}