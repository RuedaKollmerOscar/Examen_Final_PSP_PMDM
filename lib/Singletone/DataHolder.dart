import 'package:techshop/FirestoreObjects/FbComponente.dart';
import 'FirebaseAdmin.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();

  late FbComponente selectedComponente;

  FirebaseAdmin fbadmin=FirebaseAdmin();

  void initDataHolder() {}

  DataHolder._internal();

  factory DataHolder(){
    return _dataHolder;
  }
}