import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/main.dart';

class MapViewScreen extends StatefulWidget {
  MapViewScreen({required this.lat, required this.lng,required this.title,required this.desc});
  double lat = 0.0;
  double lng = 0.0;
  String title , desc = '';
  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  Set<Marker> markers = Set();
  @override
  void initState() {
    markers.add(Marker(
        markerId: const MarkerId('location'),
        position: LatLng(widget.lat, widget.lng),
      infoWindow: InfoWindow(
        title: "",
        snippet: ''
      )
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image(
            width: screenWidth / 4,
            image: AssetImage('assets/images/grey_logo.png')),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: kDarkGreyColor,
            )),
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.lat, widget.lng),
              zoom: 14.4746,
            ),
            markers: markers, // YOUR MARKS IN MAP
          ),
        ),
      ),
    );
  }
}
