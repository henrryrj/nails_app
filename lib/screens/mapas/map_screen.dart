import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nails_app/blocs/location/location_bloc.dart';
import 'package:nails_app/models/salon.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:nails_app/services/usuario_services.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LocationBloc locationBloc;
  Completer<GoogleMapController> _controller = Completer();
  ClienteService service = ClienteService();
  List<Salon> salones = [];

  final Set<Marker> markers = new Set();
  List<LatLng> polyLineCoordinates = [];

  Set<Marker> getMarkers() {
    //markers to place on map
    setState(() {
      salones.forEach((element) {
        Marker _marcador = Marker(
          markerId: MarkerId(element.id.toString()),
          position: LatLng(double.parse(element.lat!),
              double.parse(element.lon!)), //position of marker
          infoWindow: InfoWindow(
            //popup info
            title: element.descripcion,
            snippet: element.direccion,
          ),

          icon: BitmapDescriptor.defaultMarker, //Icon for Marker
        );
        markers.add(_marcador);
      });
      setState(() {});
    });

    return markers;
  }

  StreamSubscription<Position>? positionStream;
  late LatLng myPosition;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    //locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
    positionStream = Geolocator.getPositionStream().listen((event) {
      print(event.toString());
      myPosition = LatLng(event.latitude, event.longitude);
    });
  }

  getListSalones() async {
    salones = await service.listaDeSalones();
    setState(() {});
  }

  getLocation(GoogleMapController controller) async {
    await getListSalones();
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng _position = LatLng(pos.latitude, pos.longitude);
    myPosition = _position;
    controller.animateCamera(CameraUpdate.newLatLng(_position));
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    positionStream?.cancel();
    super.dispose();
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  CameraPosition _cameraInitialPosition =
      CameraPosition(target: LatLng(-17.8146, -63.1561), zoom: 15.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _cameraInitialPosition,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
              getLocation(controller);
            },
            compassEnabled: false,
            zoomControlsEnabled: false,
            layoutDirection: TextDirection.rtl,
            markers: getMarkers(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: salones.length,
                itemBuilder: (context, index) => Container(
                  child: InkWell(
                    onTap: () {
                      _controller.future.then(
                        (value) => value.animateCamera(
                          CameraUpdate.newLatLng(
                            LatLng(
                              double.parse(salones[index].lat!),
                              double.parse(
                                salones[index].lon!,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            salones[index].descripcion!,
                          ),
                          Text(
                            salones[index].direccion!,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
