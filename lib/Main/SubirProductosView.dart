import 'dart:async';
import 'package:flutter/material.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioDiscoDuro.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioDisipador.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioFuente.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioPlacas.dart';
import 'package:techshop/Custom/Views/Formularios/FormularioProcesadores.dart';
import '../Custom/Views/Formularios/FormularioCaja.dart';
import '../Custom/Widgets/CustomBottomMenu.dart';
import '../FirestoreObjects/FbCategoria.dart';
import '../Singletone/DataHolder.dart';

class SubirProductosView extends StatefulWidget {
  @override
  _SubirProductosViewState createState() => _SubirProductosViewState();
}

class _SubirProductosViewState extends State<SubirProductosView> {
  String selectedCategory = 'Categoría por defecto';

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
      appBar: AppBar(
        title: Text("Sube tus propios productos"),
        centerTitle: true,
      ),
      body: _buildBody(),
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
                Center(
                  child: Text(
                    'Selecciona la categoría para tu producto:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(child: _buildCategoryDropdown()),
                SizedBox(height: 20),
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
              SizedBox(width: 10),
              Text(categoria.sName),
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
        return FormularioProcesadores();
      case 'Memorias RAM':
        return Text('Contenido específico para Categoria3');
      case 'Tarjetas gráficas':
        return Text('Contenido específico para Categoria3');
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
}
