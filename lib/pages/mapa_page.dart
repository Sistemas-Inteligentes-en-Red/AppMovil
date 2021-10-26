import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:geolocator/geolocator.dart';

class MapaHome extends StatefulWidget {
  static const routeName = 'mapa';
  MapaHome({Key key}) : super(key: key);

  @override
  _MapaHomeState createState() => _MapaHomeState();
}

class _MapaHomeState extends State<MapaHome> {
  GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.4219999, -122.0862462),
            ),
            onMapCreated: (GoogleMapController controller) {},
          ),
        ),
      ],
    );
  }
}
