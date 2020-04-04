import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hungies/constants.dart';

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _completer = Completer();
  Set<Polyline> polylines = {};
  Set<Marker> markers = {};
  LatLng destination = LatLng(45.494276, -73.578771);

  @override
  void initState() {
    super.initState();
    List<LatLng> latlngPoints = new List();
    latlngPoints.add(LatLng(45.497044, -73.578439));
    latlngPoints.add(LatLng(45.495705, -73.579329));
    latlngPoints.add(LatLng(45.495059, -73.577913));
    latlngPoints.add(destination);

    polylines.add(Polyline(
      polylineId: PolylineId("direction"),
      points: latlngPoints,
      color: PRIMARY_COLOR,
      width: 5,
    ));
    
    markers.add(Marker(markerId: MarkerId("start"), position: destination, infoWindow: InfoWindow(title: "3 amigos")));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: true,
              indoorViewEnabled: true,
              polylines: polylines,
              markers: markers,
              initialCameraPosition: CameraPosition(
                  target: LatLng(45.4977298, -73.579034), zoom: 18),
              onMapCreated: (GoogleMapController controller) {
                _completer.complete(controller);
              },
            )),
        Positioned(
          bottom: MediaQuery
              .of(context)
              .padding
              .bottom + 16,
          right: MediaQuery
              .of(context)
              .padding
              .right + 16,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'location',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  foregroundColor: PRIMARY_COLOR,
                  child: Icon(Icons.my_location),
                ),
                SizedBox(
                  height: 16,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: PRIMARY_COLOR,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.directions),
                ),
              ]),
        ),
      ],
    );
  }
}


