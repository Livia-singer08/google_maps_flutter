import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mapa Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? pontoClicado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa Flutter'), centerTitle: true),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-22.7130000, -46.8180000),
          initialZoom: 17.0,
          onTap: (tapPosition, latLng) {
            setState(() {
              pontoClicado = latLng;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Latitude: ${latLng.latitude}\n'
                  'Longitude: ${latLng.longitude}',
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.mapa_flutter',
          ),

          if (pontoClicado != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: pontoClicado!,
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 45,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}