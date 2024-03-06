import 'package:flutter/material.dart';
import 'package:techshop/FirestoreObjects/FbCategoria.dart';
import 'package:techshop/FirestoreObjects/FbGrafica.dart';
import 'package:techshop/FirestoreObjects/FbProcesador.dart';
import 'package:techshop/FirestoreObjects/FbRAM.dart';
import '../FirestoreObjects/FbCaja.dart';
import '../FirestoreObjects/FbDiscoDuro.dart';
import '../FirestoreObjects/FbDisipador.dart';
import '../FirestoreObjects/FbFuente.dart';
import '../FirestoreObjects/FbPlaca.dart';
import '../Custom/Views/ListView/CajasListView.dart';
import '../Custom/Views/ListView/DiscosDurosListView.dart';
import '../Custom/Views/ListView/DisipadoresListView.dart';
import '../Custom/Views/ListView/FuentesListView.dart';
import '../Custom/Views/ListView/GraficasListView.dart';
import '../Custom/Views/ListView/PlacasListView.dart';
import '../Custom/Views/ListView/ProcesadoresListView.dart';
import '../Custom/Views/ListView/RAMsListView.dart';
import '../Singletone/DataHolder.dart';

class CatalogoView extends StatefulWidget {

  const CatalogoView({Key? key}) : super(key: key);

  @override
  State<CatalogoView> createState() => _CatalogoViewState();
}

class _CatalogoViewState extends State<CatalogoView> {
  FbCategoria categoriaSeleccionada = DataHolder().categoriaSeleccionada;

  // Listas para los componenetes
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

  final List<FbRAM> _rams = [];
  late Future<List<FbRAM>> _futureRAMs;

  final List<FbGrafica> _graficas = [];
  late Future<List<FbGrafica>> _futureGraficas;

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
      case 'Memorias RAM':
        return _rams.length;
      case 'Tarjetas gráficas':
        return _graficas.length;
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
          iAlmacenamiento: discoDuroSeleccionado.iAlmacenamiento,
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
          iPotencia: fuenteSeleccionada.iPotencia,
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
      case 'Memorias RAM':
        FbRAM ramSeleccionada = _rams[index];
        return RAMsListView(
          sNombre: ramSeleccionada.sNombre,
          iCapacidad: ramSeleccionada.iCapacidad,
          iModulos: ramSeleccionada.iModulos,
          iVelocidad: ramSeleccionada.iVelocidad,
          iGeneracion: ramSeleccionada.iGeneracion,
          bRGB: ramSeleccionada.bRGB,
          dPrecio: ramSeleccionada.dPrecio,
          sUrlImg: ramSeleccionada.sUrlImg,
          iPosicion: index,
          fOnItemTap: (int indice) {},
        );
      case 'Tarjetas gráficas':
        FbGrafica tarjetaGraficaSeleccionada = _graficas[index];
        return GraficasListView(
          sNombre: tarjetaGraficaSeleccionada.sNombre,
          sEnsamblador: tarjetaGraficaSeleccionada.sEnsamblador,
          sFabricante: tarjetaGraficaSeleccionada.sFabricante,
          sSerie: tarjetaGraficaSeleccionada.sSerie,
          iCapacidad: tarjetaGraficaSeleccionada.iCapacidad,
          sGeneracion: tarjetaGraficaSeleccionada.sGeneracion,
          dPrecio: tarjetaGraficaSeleccionada.dPrecio,
          sUrlImg: tarjetaGraficaSeleccionada.sUrlImg,
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
      case 'Memorias RAM':
        _futureRAMs = DataHolder().fbadmin.descargarRAMs();
        List<FbRAM> listaRAMs = await _futureRAMs;
        setState(() {
          _rams.clear();
          _rams.addAll(listaRAMs);
        });
        break;
      case 'Tarjetas gráficas':
        _futureGraficas = DataHolder().fbadmin.descargarGraficas();
        List<FbGrafica> listaGraficas = await _futureGraficas;
        setState(() {
          _graficas.clear();
          _graficas.addAll(listaGraficas);
        });
        break;
      default:
        break;
    }
  }

  Widget _separadorLista(BuildContext context, int index) {
    return Divider(thickness: 2, color: Colors.transparent);
  }
}