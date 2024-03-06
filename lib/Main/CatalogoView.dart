import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techshop/Custom/Widgets/CustomAppBar.dart';
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
  final List<FbDiscoDuro> _discosDuros = [];
  final List<FbDisipador> _disipadores = [];
  final List<FbFuente> _fuentes = [];
  final List<FbPlaca> _placas = [];
  final List<FbProcesador> _procesadores = [];
  final List<FbRAM> _rams = [];
  final List<FbGrafica> _graficas = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(title: 'Catalogo de ${categoriaSeleccionada.sName}'),
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
          fOnItemTap: _onCajaPressed,
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
          fOnItemTap: _onDiscoDuroPressed,
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
          fOnItemTap: _onDisipadorPressed,
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
          fOnItemTap: _onFuentePressed,
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
          fOnItemTap: _onPlacaPressed,
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
            fOnItemTap: _onProcesadorPressed,
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
          fOnItemTap: _onRAMPressed,
        );
      case 'Tarjetas gráficas':
        FbGrafica tarjetaGraficaSeleccionada = _graficas[index];
        return GraficasListView(
          sNombre: tarjetaGraficaSeleccionada.sNombre,
          sEnsamblador: tarjetaGraficaSeleccionada.sEnsamblador,
          sFabricante: tarjetaGraficaSeleccionada.sFabricante,
          sSerie: tarjetaGraficaSeleccionada.sSerie,
          iCapacidad: tarjetaGraficaSeleccionada.iCapacidad,
          iGeneracion: tarjetaGraficaSeleccionada.iGeneracion,
          dPrecio: tarjetaGraficaSeleccionada.dPrecio,
          sUrlImg: tarjetaGraficaSeleccionada.sUrlImg,
          iPosicion: index,
          fOnItemTap: _onGraficaPressed,
        );
      default:
        return null;
    }
  }

  Future<void> _cargarDatos() async {
    switch (categoriaSeleccionada.sName) {
      case 'Cajas':
        DataHolder().fbadmin.descargarCajas(_cargarCajas);
        break;
      case 'Discos duros':
        DataHolder().fbadmin.descargarDiscosDuros(_cargarDiscosDuros);
        break;
      case 'Disipadores':
        DataHolder().fbadmin.descargarDisipadores(_cargarDisipadores);
        break;
      case 'Fuentes de alimentación':
        DataHolder().fbadmin.descargarFuentes(_cargarFuentes);
        break;
      case 'Placas base':
        DataHolder().fbadmin.descargarPlacas(_cargarPlacas);
        break;
      case 'Procesadores':
        DataHolder().fbadmin.descargarProcesadores(_cargarProcesadores);
        break;
      case 'Memorias RAM':
        DataHolder().fbadmin.descargarRAM(cargarRAMs);
        break;
      case 'Tarjetas gráficas':
        DataHolder().fbadmin.descargarGraficas(_cargarGraficas);
        break;
      default:
        break;
    }
  }

  Widget _separadorLista(BuildContext context, int index) {
    return const Divider(thickness: 2, color: Colors.transparent);
  }


  void _onCajaPressed(int index) {
    DataHolder().cajaSeleccionada = _cajas[index];
    Navigator.of(context).pushNamed("/cajaview");
  }

  void _onDiscoDuroPressed(int index) {
    DataHolder().discoDuroSeleccionado = _discosDuros[index];
    Navigator.of(context).pushNamed("/discoduroview");
  }

  void _onDisipadorPressed(int index) {
    DataHolder().disipadorSeleccionado = _disipadores[index];
    Navigator.of(context).pushNamed("/disipadorview");
  }

  void _onFuentePressed(int index) {
    DataHolder().fuenteSeleccionada = _fuentes[index];
    Navigator.of(context).pushNamed("/fuenteview");
  }

  void _onPlacaPressed(int index) {
    DataHolder().placaSeleccionada = _placas[index];
    Navigator.of(context).pushNamed("/placaview");
  }

  void _onProcesadorPressed(int index) {
    DataHolder().procesadorSeleccionado = _procesadores[index];
    Navigator.of(context).pushNamed("/procesadorview");
  }

  void _onRAMPressed(int index) {
    DataHolder().ramSeleccionada = _rams[index];
    Navigator.of(context).pushNamed("/ramview");
  }

  void _onGraficaPressed(int index) {
    DataHolder().graficaSeleccionada = _graficas[index];
    Navigator.of(context).pushNamed("/graficaview");
  }

  void _cargarCajas(QuerySnapshot<FbCaja> cajasDescargadas) {
    if (mounted) {
      setState(() {
        _cajas.clear();
        _cajas.addAll(cajasDescargadas.docs.map((doc) => doc.data()));
      });
    }
  }

  void _cargarDiscosDuros(QuerySnapshot<FbDiscoDuro> discosDurosDescargados) {
    if (mounted) {
      setState(() {
        _discosDuros.clear();
        _discosDuros.addAll(discosDurosDescargados.docs.map((doc) => doc.data()));
      });
    }
  }

  void _cargarDisipadores(QuerySnapshot<FbDisipador> disipadoresDescargados) {
    if (mounted) {
      setState(() {
        _disipadores.clear();
        _disipadores.addAll(disipadoresDescargados.docs.map((doc) => doc.data()));
      });
    }
  }

  void _cargarFuentes(QuerySnapshot<FbFuente> fuentesDescargadas) {
    if (mounted) {
      setState(() {
        _fuentes.clear();
        _fuentes.addAll(fuentesDescargadas.docs.map((doc) => doc.data()));
      });
    }
  }

  void _cargarPlacas(QuerySnapshot<FbPlaca> placasDescargadas) {
    if (mounted) {
      setState(() {
        _placas.clear();
        _placas.addAll(placasDescargadas.docs.map((doc) => doc.data()));
      });
    }
  }

  void _cargarProcesadores(QuerySnapshot<FbProcesador> procesadoresDescargados) {
    if (mounted) {
      setState(() {
        _procesadores.clear();
        _procesadores.addAll(procesadoresDescargados.docs.map((doc) => doc.data()));
      });
    }
  }

  void cargarRAMs(QuerySnapshot<FbRAM> RAMsDescargadas) {
    if (mounted) {
      setState(() {
        _rams.clear();
        _rams.addAll(RAMsDescargadas.docs.map((doc) => doc.data()));
      });
    }
  }

  void _cargarGraficas(QuerySnapshot<FbGrafica> graficasDescargadas) {
    if (mounted) {
      setState(() {
        _graficas.clear();
        _graficas.addAll(graficasDescargadas.docs.map((doc) => doc.data()));
      });
    }
  }
}