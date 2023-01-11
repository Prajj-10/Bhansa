import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:location/location.dart';

class Google_Map extends StatefulWidget {
  @override
  State<Google_Map> createState() => Google_MapState();
}

class Google_MapState extends State<Google_Map> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  late String _mapStyle;

  LatLng? _latlng;

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.700769, 85.300140),
    zoom: 14.4746,
  );

  Future<void> getCurrentLocation() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _latlng = LatLng(_locationData.latitude!, _locationData.longitude!);

    _kGooglePlex = CameraPosition(
      target: _latlng!,
    zoom: 15,
    );
    setState(() {});
  }

  List<Marker>_markers=[];
  late LatLng latLng_global;
  void addMarker(LatLng latlng){
    // adding marker in the clicked latitude longitude
    _markers.add(Marker(
        markerId: MarkerId("adding markers"),
        draggable: true,
        position: latlng,
        onTap: (){
          //Show details of the place
          //Show distance
        },
        onDrag: (newlatlng){
          latLng_global = newlatlng;
          setState(() {
            //refresh page
          });
        }
    ));
  }

  static const CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
      target: LatLng(15.386033, 73.844040),
      tilt: 20,
      zoom: 15);
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    rootBundle.loadString('images/map.txt').then((string) {
      _mapStyle = string;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: <Marker>{
            _setMarker()
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onTap: (latlong){
            setState(() {
              addMarker(latlong);
            });
          },
          onMapCreated: (GoogleMapController controller) {
            mapController= controller;
            mapController.setMapStyle(_mapStyle);

            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  _setMarker(){
    return Marker(markerId: MarkerId("marker"),
    icon: BitmapDescriptor.defaultMarker,
      position: LatLng(27.700769, 85.300140),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}

