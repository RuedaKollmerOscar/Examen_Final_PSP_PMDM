import 'package:flutter/material.dart';
import 'package:techshop/Custom/Views/ProcesadoresListView.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import 'package:techshop/FirestoreObjects/FbProcesador.dart';
import '../Custom/Views/CajasListView.dart';
import '../Custom/Views/DiscosDurosListView.dart';
import '../Custom/Views/DisipadoresListView.dart';
import '../Custom/Views/FuentesListView.dart';
import '../Custom/Views/PlacasListView.dart';
import '../FirestoreObjects/FbCaja.dart';
import '../FirestoreObjects/FbDiscoDuro.dart';
import '../FirestoreObjects/FbDisipador.dart';
import '../FirestoreObjects/FbFuente.dart';
import '../FirestoreObjects/FbPlaca.dart';
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

  final List<FbPlaca> _placas = [];
  late Future<List<FbPlaca>> _futurePlacas;

  final List<FbProcesador> _procesadores = [];
  late Future<List<FbProcesador>> _futureProcesadores;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catálogo ${categoriaSeleccionada.sName}",
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
    switch (categoriaSeleccionada.sName) {
      case 'Cajas':
        return _cajas.length;
      case 'Discos duros':
        return _discosDuros.length;
      case 'Disipadores':
        return _disipadores.length;
      case 'Fuentes de alimentación':
        return _fuentes.length;
      case 'Placas base':
        return _placas.length;
      case 'Procesadores':
        return _procesadores.length;
      default:
        return 0;
    }
  }

  Widget? _itemListBuilder(BuildContext context, int index) {
    switch (categoriaSeleccionada.sName) {
      case 'Cajas':
        FbCaja cajaSeleccionada = _cajas[index];
        return CajasListView(
          sName: cajaSeleccionada.sNombre,
          sColor: cajaSeleccionada.sColor,
          dPeso: cajaSeleccionada.dPeso,
          dPrecio: cajaSeleccionada.dPrecio,
          sUrlImg: cajaSeleccionada.sUrlImg,
          iPosicion: index,
          fOnItemTap: (int indice) {},
        );
      case 'Discos duros':
        FbDiscoDuro discoDuroSeleccionado = _discosDuros[index];
        return DiscosDurosListView(
          sNombre: discoDuroSeleccionado.sNombre,
          sTipo: discoDuroSeleccionado.sTipo,
          iEscritura: discoDuroSeleccionado.iEscritura,
          iLectura: discoDuroSeleccionado.iLectura,
          dPrecio: discoDuroSeleccionado.dPrecio,
          sUrlImg: discoDuroSeleccionado.sUrlImg,
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
      case 'Placas base':
        FbPlaca placaSeleccionada = _placas[index];
        return PlacasListView(
          sNombre: placaSeleccionada.sNombre,
          sFactorForma: placaSeleccionada.sFactorForma,
          sSocket: placaSeleccionada.sSocket,
          sChipset: placaSeleccionada.sChipset,
          bWifi: placaSeleccionada.bWifi,
          dPrecio: placaSeleccionada.dPrecio,
          sUrlImg: placaSeleccionada.sUrlImg,
          iPosicion: index,
          fOnItemTap: (int indice) {},
        );
      case 'Procesadores':
        FbProcesador procesadorSeleccionado = _procesadores[index];
        return ProcesadoresListView(
            sNombre: procesadorSeleccionado.sNombre,
            sMarca: procesadorSeleccionado.sMarca,
            sModelo: procesadorSeleccionado.sModelo,
            iNucleos: procesadorSeleccionado.iNucleos,
            iHilos: procesadorSeleccionado.iHilos,
            dVelocidadBase: procesadorSeleccionado.dVelocidadBase,
            bOverclock: procesadorSeleccionado.bOverclock,
            dPrecio: procesadorSeleccionado.dPrecio,
            sUrlImg: procesadorSeleccionado.sUrlImg,
            iPosicion: index,
            fOnItemTap: (int indice) {},
        );
      default:
        return null;
    }
  }

  Future<void> _cargarDatos() async {
    switch (categoriaSeleccionada.sName) {
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
      case 'Placas base':
        _futurePlacas = DataHolder().fbadmin.descargarPlacas();
        List<FbPlaca> listaPlacas = await _futurePlacas;
        setState(() {
          _placas.clear();
          _placas.addAll(listaPlacas);
        });
        break;
      case 'Procesadores':
        _futureProcesadores = DataHolder().fbadmin.descargarProcesadores();
        List<FbProcesador> listaProcesadores = await _futureProcesadores;
        setState(() {
          _procesadores.clear();
          _procesadores.addAll(listaProcesadores);
        });
        break;
      default:
        break;
    }
  }


  Widget _separadorLista(BuildContext context, int index) {
    return Divider(
        thickness: 2, color: Theme.of(context).colorScheme.primary);
  }
}