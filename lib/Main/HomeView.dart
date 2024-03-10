import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:techshop/Custom/Widgets/CustomAppBar.dart';
import 'package:techshop/Custom/Widgets/CustomBottomMenu.dart';
import 'package:techshop/Custom/Widgets/CustomSnackbar.dart';
import 'package:techshop/FirestoreObjects/FbCaja.dart';
import 'package:techshop/FirestoreObjects/FbDiscoDuro.dart';
import 'package:techshop/FirestoreObjects/FbDisipador.dart';
import 'package:techshop/FirestoreObjects/FbFuente.dart';
import 'package:techshop/FirestoreObjects/FbGrafica.dart';
import 'package:techshop/FirestoreObjects/FbPlaca.dart';
import 'package:techshop/FirestoreObjects/FbProcesador.dart';
import 'package:techshop/FirestoreObjects/FbRAM.dart';
import '../Custom/Views/ListView/ComponentesListView.dart';
import '../Custom/Widgets/CustomDrawer.dart';
import '../OnBoarding/LoginView.dart';
import '../Singletone/DataHolder.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userEmail = DataHolder().fbadmin.getCurrentUserEmail() ?? "Invitado";
  late Position position;
  late FbCaja cajaRandom;
  late FbDiscoDuro discoDuroRandom;
  late FbDisipador disipadorRandom;
  late FbFuente fuenteRandom;
  late FbPlaca placaRandom;
  late FbProcesador procesadorRandom;
  late FbRAM ramRandom;
  late FbGrafica graficaRandom;
  final List<Componente> _componentes = [];

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
      appBar: const CustomAppBar(title: 'Productos destacados'),
      body: _listBody(),
      drawer: CustomDrawer(sName:userEmail.split('@')[0] , sUsername: userEmail ,fOnItemTap: _onDrawerPressed),
      bottomNavigationBar: CustomBottomMenu(fOnItemTap: _onBottomMenuPressed),
    );
  }

  void _onDrawerPressed(int indice) async {
    if(indice == 0) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else if (indice == 1) {
      Navigator.of(context).popAndPushNamed("/accountview");
    } else if (indice == 2) {
      Navigator.of(context).popAndPushNamed("/mapatiendasview");
    } else if (indice == 3) {
      Navigator.of(context).popAndPushNamed("/sobrenosotrosview");
    } else if (indice == 4) {
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
      itemCount: _componentes.length,
    );
  }

  // Creador de items en forma de lista
  Widget? _itemListBuilder(BuildContext context, int index) {
    return ComponentesListView(
      sName: _componentes[index].sNombre,
      sPrice: _componentes[index].dPrecio,
      sUrlImg: _componentes[index].sUrlImg,
      iPosicion: index,
      fOnItemTap: _onComponentePressed,
    );
  }

  Widget _separadorLista(BuildContext context, int index) {
    return const Divider(thickness: 2, color: Colors.transparent);
  }

  Future<void> determinarPosicionActual() async {
    final positionTemp = await DataHolder().geolocAdmin.determinePosition();
    setState(() {
      position = positionTemp;
    });
  }

  Future<void> _cargarComponentes() async {
    // Carga los componentes aleatorios
    cajaRandom = (await DataHolder().fbadmin.descargarCajaRandom())!;
    disipadorRandom = (await DataHolder().fbadmin.descargarDisipadorRandom())!;
    fuenteRandom = (await DataHolder().fbadmin.descargarFuenteRandom())!;
    placaRandom = (await DataHolder().fbadmin.descargarPlacaRandom())!;
    procesadorRandom = (await DataHolder().fbadmin.descargarProcesadorRandom())!;
    ramRandom = (await DataHolder().fbadmin.descargarRAMRandom())!;
    graficaRandom = (await DataHolder().fbadmin.descargarGraficaRandom())!;


    _componentes.add(Componente(sNombre: cajaRandom.sNombre, dPrecio: cajaRandom.dPrecio, sUrlImg: cajaRandom.sUrlImg));
    _componentes.add(Componente(sNombre: disipadorRandom.sNombre, dPrecio: disipadorRandom.dPrecio, sUrlImg: disipadorRandom.sUrlImg));
    _componentes.add(Componente(sNombre: fuenteRandom.sNombre, dPrecio: fuenteRandom.dPrecio, sUrlImg: fuenteRandom.sUrlImg));
    _componentes.add(Componente(sNombre: placaRandom.sNombre, dPrecio: placaRandom.dPrecio, sUrlImg: placaRandom.sUrlImg));
    _componentes.add(Componente(sNombre: procesadorRandom.sNombre, dPrecio: procesadorRandom.dPrecio, sUrlImg: procesadorRandom.sUrlImg));
    _componentes.add(Componente(sNombre: ramRandom.sNombre, dPrecio: ramRandom.dPrecio, sUrlImg: ramRandom.sUrlImg));
    _componentes.add(Componente(sNombre: graficaRandom.sNombre, dPrecio: graficaRandom.dPrecio, sUrlImg: graficaRandom.sUrlImg));

    setState(() {});
  }

  _onComponentePressed(int indice) {
    const CustomSnackbar(sMensaje: 'Si quieres saber más visita nuestros catálogos').show(context);
  }
}

class Componente {
  String sNombre;
  double dPrecio;
  String sUrlImg;

  Componente({required this.sNombre, required this.dPrecio, required this.sUrlImg});
}
