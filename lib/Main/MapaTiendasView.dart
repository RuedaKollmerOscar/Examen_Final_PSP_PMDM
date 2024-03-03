import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Set<Marker> marcadores = {};
  late CameraPosition _kUser;

  @override
  void initState() {
    super.initState();
    obtenerUbicacionActual();
    cargarTiendasYSetearMarcadores();
  }

  Future<void> cargarTiendasYSetearMarcadores() async {
    setearMarcadores();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> obtenerUbicacionActual() async {
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

  void setearMarcadores() async {
    Set<Marker> marcTemp = {};
    try {
      QuerySnapshot<FbTienda> tiendasDescargadas = await DataHolder().fbadmin.cargarTiendas();
      for (int i = 0; i < tiendasDescargadas.docs.length; i++) {
        FbTienda temp = tiendasDescargadas.docs[i].data();
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

      if (mounted) {
        setState(() {
          marcadores.addAll(marcTemp);
        });
      }
    } catch (error) {
      // Manejar el error, si es necesario
      print("Error en setearMarcadores: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Visita nuestras tiendas físicas",
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: _ubicacionActual != null
              ? GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kUser,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
            markers: marcadores,
          )
              : CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            strokeWidth: 6.0,
          ),
        ),
      ),
    );
  }
}