import 'package:flutter/material.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import '../Custom/Views/CajasListView.dart';
import '../Custom/Views/DiscosDurosListView.dart';
import '../FirestoreObjects/FbCaja.dart';
import '../FirestoreObjects/FbDiscoDuro.dart';
import '../Singletone/DataHolder.dart';

class CatalogoView extends StatefulWidget {

  const CatalogoView({Key? key}) : super(key: key);

  @override
  State<CatalogoView> createState() => _CatalogoViewState();
}

class _CatalogoViewState extends State<CatalogoView> {
  FbCategoria categoriaSeleccionada = DataHolder().categoriaSeleccionada;

  final List<FbCaja> _cajas = [];
  late Future<List<FbCaja>> _futureCajas;

  final List<FbDiscoDuro> _discosDuros = [];
  late Future<List<FbDiscoDuro>> _futureDiscosDuros;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catálogo ${categoriaSeleccionada.name}",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
          body: _listBody(),
    );
  }

  Widget _listBody() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: _itemListBuilder,
      separatorBuilder: _separadorLista,
      itemCount: _getItemCount(),
    );
  }

  int _getItemCount() {
    switch (categoriaSeleccionada.name) {
      case 'Cajas':
        return _cajas.length;
      case 'Discos duros':
        return _discosDuros.length;
      default:
        return 0;
    }
  }


  // Creador de items en forma de lista
  Widget? _itemListBuilder(BuildContext context, int index) {
      switch (categoriaSeleccionada.name) {
        case 'Cajas':
          FbCaja cajaSeleccionada = _cajas[index];
          return CajasListView(
            sName: cajaSeleccionada.nombre,
            sColor: cajaSeleccionada.color,
            dPeso: cajaSeleccionada.peso,
            dPrecio: cajaSeleccionada.precio,
            sUrlImg: cajaSeleccionada.urlImg,
            iPosicion: index,
            fOnItemTap: (int indice) {},
          );
        case 'Discos duros':
          FbDiscoDuro discoDuroSeleccionado = _discosDuros[index];
          return DiscosDurosListView(
            sNombre: discoDuroSeleccionado.nombre,
            sTipo: discoDuroSeleccionado.tipo,
            iEscritura: discoDuroSeleccionado.escritura,
            iLectura: discoDuroSeleccionado.lectura,
            dPrecio: discoDuroSeleccionado.precio,
            sUrlImg: discoDuroSeleccionado.urlImg,
            iPosicion: index,
            fOnItemTap: (int indice) {},
          );
        default:
          return null;
      }
    }

  Widget _separadorLista(BuildContext context, int index) {
    return Divider(
        thickness: 2, color: Theme.of(context).colorScheme.primary);
  }


  Future<void> _cargarDatos() async {
    if (categoriaSeleccionada.name == 'Cajas') {
      _futureCajas = DataHolder().fbadmin.descargarCajas();
      List<FbCaja> listaCajas = await _futureCajas;
      setState(() {
        _cajas.clear();
        _cajas.addAll(listaCajas);
      });
    } else if (categoriaSeleccionada.name == 'Discos duros') {
      _futureDiscosDuros = DataHolder().fbadmin.descargarDiscosDuros();
      List<FbDiscoDuro> listaDiscosDuros = await _futureDiscosDuros;
      setState(() {
        _discosDuros.clear();
        _discosDuros.addAll(listaDiscosDuros);
      });
    }
  }
}




