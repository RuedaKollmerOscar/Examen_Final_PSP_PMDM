import 'package:techshop/FirestoreObjects/FbCaja.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import 'package:techshop/FirestoreObjects/FbComponente.dart';
import 'package:techshop/FirestoreObjects/FbDiscoDuro.dart';
import 'package:techshop/FirestoreObjects/FbDisipador.dart';
import 'package:techshop/FirestoreObjects/FbFuente.dart';
import 'package:techshop/FirestoreObjects/FbGrafica.dart';
import 'package:techshop/FirestoreObjects/FbPlaca.dart';
import 'package:techshop/FirestoreObjects/FbProcesador.dart';
import 'package:techshop/FirestoreObjects/FbRAM.dart';
import 'FirebaseAdmin.dart';
import 'GeolocAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  late FbComponente componenteSeleccionado;
  late FbCategoria categoriaSeleccionada;
  late FbCaja cajaSeleccionada;
  late FbDiscoDuro discoDuroSeleccionado;
  late FbDisipador disipadorSeleccionado;
  late FbFuente fuenteSeleccionada;
  late FbPlaca placaSeleccionada;
  late FbProcesador procesadorSeleccionado;
  late FbRAM ramSeleccionada;
  late FbGrafica graficaSeleccionada;

  FirebaseAdmin fbadmin=FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();

  void initDataHolder() {}

  DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }
}