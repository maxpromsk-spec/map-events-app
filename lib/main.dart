import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Карта событий',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const DemoMapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoMapScreen extends StatefulWidget {
  const DemoMapScreen({super.key});
  
  @override
  State<DemoMapScreen> createState() => _DemoMapScreenState();
}

class _DemoMapScreenState extends State<DemoMapScreen> {
  MapLibreMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🗺 Карта событий')),
      body: MapLibreMap(
        styleString: 'https://demotiles.maplibre.org/style.json',
        initialCameraPosition: const CameraPosition(
          target: LatLng(55.7558, 37.6173),
          zoom: 12,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
          controller.addSymbol(const SymbolOptions(
            geometry: LatLng(55.7558, 37.6173),
            iconImage: 'default-marker',
            textField: 'Привет!',
          ));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Работает!')),
          );
        },
        icon: const Icon(Icons.add_location),
        label: const Text('Добавить'),
      ),
    );
  }
}
