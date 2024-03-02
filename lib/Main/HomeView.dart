import 'package:flutter/material.dart';

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
  final List<FbComponente> componentes = [];
  late Future<List<FbComponente>> futureComponentes;
  @override
  void initState() {
    super.initState();
    cargarComponentes();
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: listBody(),
      drawer: CustomDrawer(fOnItemTap: onDrawerPressed),
    );
  }

  void onDrawerPressed(int indice) async {
    if (indice == 4) {
    DataHolder().fbadmin.cerrarSesion();
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => const LoginView()),
    ModalRoute.withName("/loginview"));
    }
  }


  Widget listBody() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemBuilder: itemListBuilder,
      separatorBuilder: separadorLista,
      itemCount: componentes.length,
    );
  }

  // Creador de items en forma de lista
  Widget? itemListBuilder(BuildContext context, int index) {
    return ComponentesListView(
        sName: componentes[index].name,
        sPrice: componentes[index].price,
        iPosicion: index,
        fOnItemTap: onPostPressed,
    );
  }

  Widget separadorLista(BuildContext context, int index) {
    return Divider(
        thickness: 2,
        color: Theme.of(context).colorScheme.primary
    );
  }

  // Gestiona el click del post
  void onPostPressed(int index) {
    DataHolder().selectedComponente = componentes[index];
  }

  // Llena la lista de posts
  Future<void> cargarComponentes() async {
    futureComponentes = DataHolder().fbadmin.descargarComponentes();
    List<FbComponente> listaComponentes = await futureComponentes;
    setState(() {
      componentes.clear();
      componentes.addAll(listaComponentes);
    });
  }
}