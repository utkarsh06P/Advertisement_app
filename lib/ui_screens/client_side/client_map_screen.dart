import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'client_analytics_screen.dart';
import 'client_request_form_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  
  // Default position (Delhi)
  LatLng currentPosition = LatLng(28.7041, 77.1025);
  List<Marker> markers = [];

  void _updateMarker() {
    try {
      double lat = double.parse(latController.text);
      double lng = double.parse(lngController.text);
      
      setState(() {
        currentPosition = LatLng(lat, lng);
        markers = [
          Marker(
            point: currentPosition,
            width: 80,
            height: 80,
            child: const Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 40,
            ),
          ),
        ];
        
        mapController.move(currentPosition, 12);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid coordinates')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0), // Add padding for spacing
            child: ElevatedButton(
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
                  );
              },
              child: Text('Dashboard', style: TextStyle(color: Theme.of(context).primaryColor),),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: latController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Latitude',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: lngController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _updateMarker,
                  child: Text('Update'),
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentPosition,
                initialZoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestFormScreen()), // Navigate to Map Screen
                );
              },
              backgroundColor: Theme.of(context).primaryColor, // Customize button color
              child: const Icon(Icons.map, color: Colors.white), // Map icon inside button
            ),
            const SizedBox(height: 8), // Space between button and text
            const Text(
              'Request Form',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    latController.dispose();
    lngController.dispose();
    super.dispose();
  }
}