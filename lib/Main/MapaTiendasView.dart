import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:techshop/Custom/Widgets/CustomAppBar.dart';
import 'package:techshop/Singletone/DataHolder.dart';
import '../FirestoreObjects/FbTienda.dart';

class MapaTiendasView extends StatefulWidget {
  const MapaTiendasView({Key? key}) : super(key: key);

  @override
  State<MapaTiendasView> createState() => MapaTiendasViewState();
}

class MapaTiendasViewState extends State<MapaTiendasView> {
  Position? _ubicacionActual;
  late GoogleMapController _controller;
  final Set<Marker> _marcadores = {};
  late CameraPosition _kUser;
  MapType _mapType = MapType.normal;
  double _radioBusqueda = double.infinity;

  @override
  void initState() {
    super.initState();
    _obtenerUbicacionActual();
    _cargarTiendasYSetearMarcadores();
  }

  Future<void> _cargarTiendasYSetearMarcadores() async {
    _setearMarcadores();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        title: 'Visita nuestras tiendas físicas',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () async {
              await _dialogoRadio(context);
            },
          ),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            icon: Icon(
              Icons.map,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            color: Theme.of(context).colorScheme.background,
            onSelected: (caso) {
              switch (caso) {
                case 'mapaNormal':
                  _cambiarTipoMapa(MapType.normal);
                  break;
                case 'mapaSatelite':
                  _cambiarTipoMapa(MapType.satellite);
                  break;
                case 'mapaHibrido':
                  _cambiarTipoMapa(MapType.hybrid);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'mapaNormal',
                child: ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Mapa normal',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'mapaSatelite',
                child: ListTile(
                  leading: Icon(
                    Icons.satellite,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Mapa satélite',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                value: 'mapaHibrido',
                child: ListTile(
                  leading: Icon(
                    Icons.layers,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Mapa híbrido',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: _ubicacionActual != null
              ? GoogleMap(
            mapType: _mapType,
            initialCameraPosition: _kUser,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: _marcadores,
          )
              : SpinKitThreeBounce(
            color: Theme.of(context).colorScheme.primary,
            size: 25.0,
          ),
        ),
      ),
    );
  }

  bool _estaEnRadio(double latitud, double longitud, double radio) {
    if (_ubicacionActual == null) {
      return false;
    }

    double distancia = Geolocator.distanceBetween(
      _ubicacionActual!.latitude,
      _ubicacionActual!.longitude,
      latitud,
      longitud,
    );

    double distanciaEnKilometros = distancia / 1000;
    return distanciaEnKilometros <= radio;
  }

  Future<void> _obtenerUbicacionActual() async {
    final posicion = await Geolocator.getCurrentPosition();
    setState(() {
      _ubicacionActual = posicion;
      _kUser = CameraPosition(
        target: LatLng(
          _ubicacionActual!.latitude,
          _ubicacionActual!.longitude,
        ),
        zoom: 15.0,
      );
    });
  }

  void _setearMarcadores() async {
    Set<Marker> marcTemp = {};
    try {
      QuerySnapshot<FbTienda> tiendasDescargadas =
      await DataHolder().fbadmin.cargarTiendas();
      for (int i = 0; i < tiendasDescargadas.docs.length; i++) {
        FbTienda temp = tiendasDescargadas.docs[i].data();
        if (_ubicacionActual != null &&
            _estaEnRadio(temp.geoloc.latitude, temp.geoloc.longitude, _radioBusqueda)) {
          Marker marcadorTemp = Marker(
            markerId: MarkerId(tiendasDescargadas.docs[i].id),
            position: LatLng(temp.geoloc.latitude, temp.geoloc.longitude),
            infoWindow: InfoWindow(
              title: temp.name,
              snippet: "Localidad: ${temp.loc}",
            ),
          );
          marcTemp.add(marcadorTemp);
        }
      }

      if (mounted) {
        setState(() {
          _marcadores.clear();
          _marcadores.addAll(marcTemp);
        });
      }
    } catch (error) {
      // Manejar el error, si es necesario
      print("Error en setearMarcadores: $error");
    }
  }

  void _cambiarTipoMapa(MapType nuevoTipoMapa) {
    setState(() {
      _mapType = nuevoTipoMapa;
    });
  }

  Future<void> _dialogoRadio(BuildContext context) async {
    String selectedRadio = _radioBusqueda == double.infinity
        ? 'Sin límite'
        : _radioBusqueda.round().toString();

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(
                'Seleccione el radio de busqueda',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: selectedRadio,
                    items: ['1', '5', '10', '30', '50', 'Sin límite']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value == 'Sin límite' ? 'Sin límite' : '$value km',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRadio = newValue!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      switch (selectedRadio) {
                        case 'Sin límite':
                          _radioBusqueda = double.infinity;
                          break;
                        default:
                          _radioBusqueda = double.parse(selectedRadio);
                          break;
                      }
                      Navigator.pop(context, selectedRadio);
                      _setearMarcadores();
                      setState;
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.inversePrimary
                    ),
                    child: const Text('Aceptar')
                ),
              ],
            );
          },
        );
      },
    );
  }
}
