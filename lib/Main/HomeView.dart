import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../Custom/Views/ComponentesListView.dart';
import '../Custom/Widgets/CustomDrawer.dart';
import '../FirestoreObjects/FbComponente.dart';
import '../OnBoarding/LoginView.dart';
import '../Singletone/DataHolder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<FbComponente> _componentes = [];

  late Position position;
  late Future<List<FbComponente>> _futureComponentes;

  @override
  void initState() {
    super.initState();
    _cargarComponentes();
    initData();
  }

  Future<void> initData() async {
    await determinarPosicionActual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "H O M E",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent
      ),
      body: _listBody(),
      drawer: CustomDrawer(fOnItemTap: _onDrawerPressed),
    );
  }

  void _onDrawerPressed(int indice) async {
    if(indice == 0) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else if (indice == 3) {
      Navigator.of(context).popAndPushNamed("/mapatiendasview");
    }
    else if (indice == 2) {
      Navigator.of(context).popAndPushNamed("/accountview");
    } else if (indice == 4) {
      DataHolder().fbadmin.cerrarSesion();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
        ModalRoute.withName("/loginview"),
      );
    }
  }

  // Gestiona el click del post
  void _onComponentePressed(int index) {
    DataHolder().componenteSeleccionado = _componentes[index];
    Navigator.of(context).pushNamed("/componenteview");
  }


  Widget _listBody() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: _itemListBuilder,
      separatorBuilder: separadorLista,
      itemCount: _componentes.length,
    );
  }

  // Creador de items en forma de lista
  Widget? _itemListBuilder(BuildContext context, int index) {
    return ComponentesListView(
      sName: _componentes[index].name,
      sPrice: _componentes[index].price,
      iPosicion: index,
      fOnItemTap: _onComponentePressed,
    );
  }

  Widget separadorLista(BuildContext context, int index) {
    return Divider(
        thickness: 2, color: Theme.of(context).colorScheme.primary);
  }

  // Llena la lista de posts
  Future<void> _cargarComponentes() async {
    _futureComponentes = DataHolder().fbadmin.descargarComponentes();
    List<FbComponente> listaComponentes = await _futureComponentes;
    setState(() {
      _componentes.clear();
      _componentes.addAll(listaComponentes);
    });
  }

  Future<void> determinarPosicionActual() async {
    final positionTemp = await DataHolder().geolocAdmin.determinePosition();
    setState(() {
      position = positionTemp;
    });
  }
}