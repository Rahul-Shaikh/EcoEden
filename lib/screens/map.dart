import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatelessWidget {
  final String lat;
  final String lng;
  MapPage({this.lat,this.lng});

  GoogleMapController _controller;
  List<Placemark> placemark;
  String _address;
  void getAddress(double latitude,double longitude) async {
    placemark = await Geolocator().placemarkFromCoordinates(latitude, longitude);
    _address = placemark[0].name.toString() + ", " +
        placemark[0].locality.toString() + ", Postal Code:" +
        placemark[0].postalCode.toString();

  }

  Set<Marker> _createMarker() {
    //print("Porny" + _address);
    return <Marker>[
      Marker(
        markerId: MarkerId('Home'),
        position: LatLng(double.parse(lat),double.parse(lng)),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'Trash' ,snippet: _address ),//snippet: _address
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    getAddress(double.parse(lat),double.parse(lng));
    print("Porny" );
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(double.parse(lat),double.parse(lng)),
        zoom: 12.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }
}
