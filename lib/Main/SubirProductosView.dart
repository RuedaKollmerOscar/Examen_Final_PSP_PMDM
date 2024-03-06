import 'dart:async';
import 'package:flutter/material.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioDiscoDuro.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioDisipador.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioFuente.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioGrafica.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioPlaca.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioProcesador.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioRAM.dart';
import 'package:techshop/Custom/Widgets/CustomAppBar.dart';
import '../Custom/Views/Formularios/FormularioCaja.dart';
import '../Custom/Widgets/CustomBottomMenu.dart';
import '../Custom/Widgets/CustomDrawer.dart';
import '../FirestoreObjects/FbCategoria.dart';
import '../OnBoarding/LoginView.dart';
import '../Singletone/DataHolder.dart';

class SubirProductosView extends StatefulWidget {
  const SubirProductosView({super.key});

  @override
  _SubirProductosViewState createState() => _SubirProductosViewState();
}

class _SubirProductosViewState extends State<SubirProductosView> {
  String selectedCategory = 'Categoría por defecto';

  final List<FbCategoria> _categorias = [FbCategoria(sName: 'Categoría por defecto', sUrlImg: '')];
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
      appBar: CustomAppBar(title: 'Sube tus propios productos'),
      body: _buildBody(),
      drawer: CustomDrawer(fOnItemTap: _onDrawerPressed),
      bottomNavigationBar: CustomBottomMenu(fOnItemTap: _onBottomMenuPressed),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Selecciona la categoría para tu producto:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: _buildCategoryDropdown()),
                const SizedBox(height: 20),
                Center(child: _buildCategorySpecificContent()),
              ],
            ),
          ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButton<FbCategoria>(
      value: _categorias.firstWhere((cat) => cat.sName == selectedCategory,
          orElse: () => _categorias.first),
      onChanged: (FbCategoria? newValue) {
        setState(() {
          selectedCategory = newValue?.sName ?? 'Categoría por defecto ';
        });
      },
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      items: _categorias.map((FbCategoria categoria) {
        return DropdownMenuItem<FbCategoria>(
          value: categoria,
          child: Row(
              children: [
                if (categoria.sUrlImg.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      categoria.sUrlImg,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(width: 10),
                Text(
                  categoria.sName,
                  style: const TextStyle(
                    color: Colors.white, // Cambia el color del texto del elemento de la lista
                  ),
                ),
              ],
            ),
        );
      }).toList(),
    );
  }

  Widget _buildCategorySpecificContent() {
    switch (selectedCategory) {
      case 'Cajas':
        return FormularioCaja();
      case 'Discos duros':
        return FormularioDiscoDuro();
      case 'Disipadores':
        return FormularioDisipador();
      case 'Fuentes de alimentación':
        return FormularioFuente();
      case 'Placas base':
        return FormularioPlacaBase();
      case 'Procesadores':
        return FormularioProcesador();
      case 'Memorias RAM':
        return FormularioRAM();
      case 'Tarjetas gráficas':
        return FormularioGrafica();
      default:
        return FormularioCaja();
    }
  }

  void _onBottomMenuPressed(int indice) {
    if (indice == 0) {
      Navigator.of(context).popAndPushNamed("/homeview");
    } else if (indice == 1) {
      Navigator.of(context).popAndPushNamed("/categoriasview");
    } else if (indice == 2) {
      Navigator.of(context).popAndPushNamed("/subirproductosview");
    }
  }

  Future<void> _cargarCategorias() async {
    _futureCategorias = DataHolder().fbadmin.descargarCategorias();
    List<FbCategoria> listaCategorias = await _futureCategorias;
    setState(() {
      _categorias.clear();
      _categorias.addAll(listaCategorias);
    });
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
}
