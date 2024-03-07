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
  final Map<String, FbCaja> _cajas = {};
  final Map<String, FbDiscoDuro> _discosDuros = {};
  final Map<String, FbDisipador> _disipadores = {};
  final Map<String, FbFuente> _fuentes = {};
  final Map<String, FbPlaca> _placas = {};
  final Map<String, FbProcesador> _procesadores = {};
  final Map<String, FbRAM> _rams = {};
  final Map<String, FbGrafica> _graficas = {};

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
        List<FbCaja> cajasList = _cajas.values.toList();

        if (index >= 0 && index < cajasList.length) {
          FbCaja cajaSeleccionada = cajasList[index];

          return CajasListView(
            sName: cajaSeleccionada.sNombre,
            sColor: cajaSeleccionada.sColor,
            dPeso: cajaSeleccionada.dPeso,
            dPrecio: cajaSeleccionada.dPrecio,
            sUrlImg: cajaSeleccionada.sUrlImg,
            iPosicion: index,
            fOnItemTap: _onCajaPressed,
          );
        } else return Container();
      case 'Discos duros':
        List<FbDiscoDuro> discosDurosList = _discosDuros.values.toList();

        if (index >= 0 && index < discosDurosList.length) {
          FbDiscoDuro discoDuroSeleccionado = discosDurosList[index];

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
        } else return Container();
      case 'Disipadores':
        List<FbDisipador> disipadoresList = _disipadores.values.toList();

        if (index >= 0 && index < disipadoresList.length) {
          FbDisipador disipadorSeleccionado = disipadoresList[index];

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
        } else return Container();
      case 'Fuentes de alimentación':
        List<FbFuente> fuentesList = _fuentes.values.toList();

        if (index >= 0 && index < fuentesList.length) {
          FbFuente fuenteSeleccionada = fuentesList[index];

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
        } else return Container();
      case 'Placas base':
        List<FbPlaca> placasList = _placas.values.toList();

        if (index >= 0 && index < placasList.length) {
          FbPlaca placaSeleccionada = placasList[index];

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
        } else return Container();
      case 'Procesadores':
        List<FbProcesador> procesadoresList = _procesadores.values.toList();

        if (index >= 0 && index < procesadoresList.length) {
          FbProcesador procesadorSeleccionado = procesadoresList[index];

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
        } else return Container();
      case 'Memorias RAM':
        List<FbRAM> ramsList = _rams.values.toList();

        if (index >= 0 && index < ramsList.length) {
          FbRAM ramSeleccionada = ramsList[index];

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
            fOnItemTap: _onRAMPressed
          );
        } else return Container();
      case 'Tarjetas gráficas':
        List<FbGrafica> graficasList = _graficas.values.toList();

        if (index >= 0 && index < graficasList.length) {
          FbGrafica tarjetaGraficaSeleccionada = graficasList[index];

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
        } else return Container();
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
        DataHolder().fbadmin.descargarRAM(_cargarRAMs);
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
    List<FbCaja> cajasList = _cajas.values.toList();
    if (index >= 0 && index < cajasList.length) {
      DataHolder().cajaSeleccionada = cajasList[index];
      DataHolder().idCajaSeleccionada = _cajas.keys.elementAt(index);
      Navigator.of(context).pushNamed("/cajaview");
    } else {
      print("Índice fuera de rango");
    }
  }

  void _onDiscoDuroPressed(int index) {
    List<FbDiscoDuro> discosDurosList = _discosDuros.values.toList();
    if (index >= 0 && index < discosDurosList.length) {
      DataHolder().discoDuroSeleccionado = discosDurosList[index];
      DataHolder().idDiscoDuroSeleccionado = _discosDuros.keys.elementAt(index);
      Navigator.of(context).pushNamed("/discoduroview");
    } else {
      print("Índice fuera de rango");
    }
  }


  void _onDisipadorPressed(int index) {
    List<FbDisipador> disipadoresList = _disipadores.values.toList();
    if (index >= 0 && index < disipadoresList.length) {
      DataHolder().disipadorSeleccionado = disipadoresList[index];
      DataHolder().idDisipadorSeleccionado = _disipadores.keys.elementAt(index);
      Navigator.of(context).pushNamed("/disipadorview");
    } else {
      print("Índice fuera de rango");
    }
  }

  void _onFuentePressed(int index) {
    List<FbFuente> fuentesList = _fuentes.values.toList();
    if (index >= 0 && index < fuentesList.length) {
      DataHolder().fuenteSeleccionada = fuentesList[index];
      DataHolder().idFuenteSeleccionada = _fuentes.keys.elementAt(index);
      Navigator.of(context).pushNamed("/fuenteview");
    } else {
      print("Índice fuera de rango");
    }
  }

  void _onPlacaPressed(int index) {
    List<FbPlaca> placasList = _placas.values.toList();
    if (index >= 0 && index < placasList.length) {
      DataHolder().placaSeleccionada = placasList[index];
      DataHolder().idPlacaSeleccionada = _placas.keys.elementAt(index);
      Navigator.of(context).pushNamed("/placaview");
    } else {
      print("Índice fuera de rango");
    }
  }

  void _onProcesadorPressed(int index) {
    List<FbProcesador> procesadoresList = _procesadores.values.toList();
    if (index >= 0 && index < procesadoresList.length) {
      DataHolder().procesadorSeleccionado = procesadoresList[index];
      DataHolder().idProcesadorSeleccionado = _procesadores.keys.elementAt(index);
      Navigator.of(context).pushNamed("/procesadorview");
    } else {
      print("Índice fuera de rango");
    }
  }

  void _onRAMPressed(int index) {
    List<FbRAM> ramsList = _rams.values.toList();
    if (index >= 0 && index < ramsList.length) {
      DataHolder().ramSeleccionada = ramsList[index];
      DataHolder().idRAMSeleccionada = _rams.keys.elementAt(index);
      Navigator.of(context).pushNamed("/ramview");
    } else {
      print("Índice fuera de rango");
    }
  }

  void _onGraficaPressed(int index) {
    List<FbGrafica> graficasList = _graficas.values.toList();
    if (index >= 0 && index < graficasList.length) {
      DataHolder().graficaSeleccionada = graficasList[index];
      DataHolder().idGraficaSeleccionada = _graficas.keys.elementAt(index);
      Navigator.of(context).pushNamed("/graficaview");
    } else {
      print("Índice fuera de rango");
    }
  }



  void _cargarCajas(QuerySnapshot<FbCaja> cajasDescargadas) {
    if (mounted) {
      setState(() {
        _cajas.clear();
        _cajas.addAll(Map.fromEntries(cajasDescargadas.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarDiscosDuros(QuerySnapshot<FbDiscoDuro> discosDurosDescargados) {
    if (mounted) {
      setState(() {
        _discosDuros.clear();
        _discosDuros.addAll(Map.fromEntries(discosDurosDescargados.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarDisipadores(QuerySnapshot<FbDisipador> disipadoresDescargados) {
    if (mounted) {
      setState(() {
        _disipadores.clear();
        _disipadores.addAll(Map.fromEntries(disipadoresDescargados.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarFuentes(QuerySnapshot<FbFuente> fuentesDescargadas) {
    if (mounted) {
      setState(() {
        _fuentes.clear();
        _fuentes.addAll(Map.fromEntries(fuentesDescargadas.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarPlacas(QuerySnapshot<FbPlaca> placasDescargadas) {
    if (mounted) {
      setState(() {
        _placas.clear();
        _placas.addAll(Map.fromEntries(placasDescargadas.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarProcesadores(QuerySnapshot<FbProcesador> procesadoresDescargados) {
    if (mounted) {
      setState(() {
        _procesadores.clear();
        _procesadores.addAll(Map.fromEntries(procesadoresDescargados.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarRAMs(QuerySnapshot<FbRAM> RAMsDescargadas) {
    if (mounted) {
      setState(() {
        _rams.clear();
        _rams.addAll(Map.fromEntries(RAMsDescargadas.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }

  void _cargarGraficas(QuerySnapshot<FbGrafica> graficasDescargadas) {
    if (mounted) {
      setState(() {
        _graficas.clear();
        _graficas.addAll(Map.fromEntries(graficasDescargadas.docs.map(
              (doc) => MapEntry(doc.id, doc.data()),
        )));
      });
    }
  }
}