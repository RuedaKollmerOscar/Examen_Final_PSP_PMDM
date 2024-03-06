import 'package:flutter/material.dart';

import '../Custom/Views/ListView/CategoriasListView.dart';
import '../Custom/Widgets/CustomBottomMenu.dart';
import '../Custom/Widgets/CustomDrawer.dart';
import '../FirestoreObjects/FbCategoria.dart';
import '../OnBoarding/LoginView.dart';
import '../Singletone/DataHolder.dart';

class CategoriasView extends StatefulWidget {
  @override
  State<CategoriasView> createState() => _CategoriasViewState();
}

class _CategoriasViewState extends State<CategoriasView> {
  final List<FbCategoria> _categorias = [];
  late Future<List<FbCategoria>> _futureCategorias;

  @override
  void initState() {
    super.initState();
    _cargarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Categorías",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        shadowColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 5,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: _listBody(),
      drawer: CustomDrawer(fOnItemTap: _onDrawerPressed),
      bottomNavigationBar: CustomBottomMenu(fOnItemTap: _onBottomMenuPressed),
    );
  }

  void _onDrawerPressed(int indice) async {
    if(indice == 0) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else if (indice == 2) {
      Navigator.of(context).popAndPushNamed("/accountview");
    } else if (indice == 3) {
      Navigator.of(context).popAndPushNamed("/mapatiendasview");
    } else if (indice == 4) {
      Navigator.of(context).popAndPushNamed("/sobrenosotrosview");
    } else if (indice == 5) {
      DataHolder().fbadmin.cerrarSesion();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
        ModalRoute.withName("/loginview"),
      );
    }
  }

  void _onBottomMenuPressed(int indice) {
    if(indice == 0) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else if (indice == 1) {
      Navigator.of(context).popAndPushNamed("/categoriasview");
    } else if (indice == 2) {
      Navigator.of(context).popAndPushNamed("/subirproductosview");
    }
  }

  Widget _listBody() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: _itemListBuilder,
      separatorBuilder: _separadorLista,
      itemCount: _categorias.length,
    );
  }

  Widget? _itemListBuilder(BuildContext context, int index) {
    return CategoriasListView(
      sName: _categorias[index].sName,
      sUrlImg: _categorias[index].sUrlImg,
      iPosicion: index,
      fOnItemTap: _onCategoriaPressed,
    );
  }

  Widget _separadorLista(BuildContext context, int index) {
    return Divider(thickness: 2, color: Colors.transparent);
  }

  void _onCategoriaPressed(int index) {
    DataHolder().categoriaSeleccionada = _categorias[index];
    Navigator.of(context).pushNamed("/catalogoview");
  }

  Future<void> _cargarCategorias() async {
    _futureCategorias = DataHolder().fbadmin.descargarCategorias();
    List<FbCategoria> listaCategorias = await _futureCategorias;
    setState(() {
      _categorias.clear();
      _categorias.addAll(listaCategorias);
    });
  }
}