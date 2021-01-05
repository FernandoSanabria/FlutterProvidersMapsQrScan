import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  MapType mapType = MapType.normal;

  

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    final double coordinateOne= double.parse(arguments['coordinateOne']);
    final double coordinateTwo= double.parse(arguments['coordinateTwo']);

  Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'),
        position: LatLng(coordinateOne, coordinateTwo)));



    final CameraPosition _passedPosition = CameraPosition(
    target: LatLng(coordinateOne, coordinateTwo),
    zoom: 12,
  );



    return new Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: GoogleMap(
        mapType: mapType,
        initialCameraPosition: _passedPosition,
         markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }



}
