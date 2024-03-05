import 'package:flutter/material.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import '../Custom/Views/CajasListView.dart';
import '../Custom/Views/DiscosDurosListView.dart';
import '../Custom/Views/DisipadoresListView.dart';
import '../Custom/Views/FuentesListView.dart';
import '../FirestoreObjects/FbCaja.dart';
import '../FirestoreObjects/FbDiscoDuro.dart';
import '../FirestoreObjects/FbDisipador.dart';
import '../FirestoreObjects/FbFuente.dart';
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

  final List<FbDisipador> _disipadores = [];
  late Future<List<FbDisipador>> _futureDisipadores;

  final List<FbFuente> _fuentes = [];
  late Future<List<FbFuente>> _futureFuentes;

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
            fontSize: 18,
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
      case 'Disipadores':
        return _disipadores.length;
      case 'Fuentes de alimentación':
        return _fuentes.length;
      default:
        return 0;
    }
  }

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
      case 'Disipadores':
        FbDisipador disipadorSeleccionado = _disipadores[index];
        return DisipadoresListView(
          sNombre: disipadorSeleccionado.sNombre,
          sColor: disipadorSeleccionado.sColor,
          sMaterial: disipadorSeleccionado.sMaterial,
          iVelocidadRotacionMinima: disipadorSeleccionado.iVelocidadRotacionMinima,
          iVelocidadRotacionMaxima: disipadorSeleccionado.iVelocidadRotacionMaxima,
          dPrecio: disipadorSeleccionado.dPrecio,
          sUrlImg: disipadorSeleccionado.sUrlImg,
          iPosicion: index,
          fOnItemTap: (int indice) {},
        );
      case 'Fuentes de alimentación':
        FbFuente fuenteSeleccionada = _fuentes[index];
        return FuentesListView(
          sNombre: fuenteSeleccionada.sNombre,
          sTipoCableado: fuenteSeleccionada.sTipoCableado,
          sFormato: fuenteSeleccionada.sFormato,
          dPotencia: fuenteSeleccionada.dPotencia,
          sCertificacion: fuenteSeleccionada.sCertificacion,
          sUrlImg: fuenteSeleccionada.sUrlImg,
          dPrecio: fuenteSeleccionada.dPrecio,
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
    switch (categoriaSeleccionada.name) {
      case 'Cajas':
        _futureCajas = DataHolder().fbadmin.descargarCajas();
        List<FbCaja> listaCajas = await _futureCajas;
        setState(() {
          _cajas.clear();
          _cajas.addAll(listaCajas);
        });
        break;
      case 'Discos duros':
        _futureDiscosDuros = DataHolder().fbadmin.descargarDiscosDuros();
        List<FbDiscoDuro> listaDiscosDuros = await _futureDiscosDuros;
        setState(() {
          _discosDuros.clear();
          _discosDuros.addAll(listaDiscosDuros);
        });
        break;
      case 'Disipadores':
        _futureDisipadores = DataHolder().fbadmin.descargarDisipadores();
        List<FbDisipador> listaDisipadores = await _futureDisipadores;
        setState(() {
          _disipadores.clear();
          _disipadores.addAll(listaDisipadores);
        });
        break;
      case 'Fuentes de alimentación':
        _futureFuentes = DataHolder().fbadmin.descargarFuentes();
        List<FbFuente> listaFuentes = await _futureFuentes;
        setState(() {
          _fuentes.clear();
          _fuentes.addAll(listaFuentes);
        });
        break;
      default:
        break;
    }
  }
}