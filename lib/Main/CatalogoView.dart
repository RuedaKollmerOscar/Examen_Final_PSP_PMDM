import 'package:flutter/material.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import '../Custom/Views/CajasListView.dart';
import '../FirestoreObjects/FbCaja.dart';
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

  @override
  void initState() {
    super.initState();
    _cargarCajas();
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
      itemCount: _cajas.length,
    );
  }

  // Creador de items en forma de lista
  Widget? _itemListBuilder(BuildContext context, int index) {
    FbCaja cajaSeleccionada = _cajas[index];
    return CajasListView(
      sName: cajaSeleccionada.nombre,
      sColor: cajaSeleccionada.color,
      dPeso: cajaSeleccionada.peso,
      dPrecio: cajaSeleccionada.precio,
      sUrlImg: cajaSeleccionada.urlImg,
      iPosicion: index,
      fOnItemTap: (int indice) {  },
    );
  }

  Widget _separadorLista(BuildContext context, int index) {
    return Divider(
        thickness: 2, color: Theme.of(context).colorScheme.primary);
  }

  // Llena la lista de posts
  Future<void> _cargarCajas() async {
    _futureCajas = DataHolder().fbadmin.descargarCajas();
    List<FbCaja> listaCajas = await _futureCajas;
    setState(() {
      _cajas.clear();
      _cajas.addAll(listaCajas);
    });
  }
}
