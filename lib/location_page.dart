import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectionPage extends StatefulWidget {
  const LocationSelectionPage({super.key});

  @override
  State<LocationSelectionPage> createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  // Karachi, Pakistan coordinates
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(24.8607, 67.0011),
    zoom: 14.0,
  );

  void _onMapTapped(LatLng position) {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId("selected-location"),
          position: position,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      // Stack use kiya hai taake map ke upar buttons aa sakein
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            onMapCreated: (controller) => mapController = controller,
            markers: markers,
            onTap: _onMapTapped,
          ),
          
          // Confirm Button at bottom
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                if (markers.isNotEmpty) {
                  // Yahan aap backend ko coordinate bhej sakti hain
                  print("Final Location: ${markers.first.position}");
                }
              },
              child: const Text("Confirm Location", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}