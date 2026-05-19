import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entity/user_entity.dart';

class SimulatedMapWidget extends StatefulWidget {
  final UserEntity userData;
  final bool isFullScreen;

  const SimulatedMapWidget({
    super.key,
    required this.userData,
    this.isFullScreen = false,
  });

  @override
  State<SimulatedMapWidget> createState() => _SimulatedMapWidgetState();
}

class _SimulatedMapWidgetState extends State<SimulatedMapWidget> {
  final MapController _mapController = MapController();

  late LatLng _pointA;
  late LatLng _pointB;
  late LatLng _midPoint;

  @override
  void initState() {
    super.initState();

    _pointA = LatLng(widget.userData.latA, widget.userData.lngA);
    _pointB = LatLng(widget.userData.latB, widget.userData.lngB);
    _midPoint = LatLng(
      (widget.userData.latA + widget.userData.latB) / 2,
      (widget.userData.lngA + widget.userData.lngB) / 2,
    );
  }

  void _fitBounds() {
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds(_pointA, _pointB),
        padding: EdgeInsets.all(widget.isFullScreen ? 80.0 : 40.0),
      ),
    );
  }

  void _zoomIn() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom + 1.0);
  }

  void _zoomOut() {
    final currentZoom = _mapController.camera.zoom;
    _mapController.move(_mapController.camera.center, currentZoom - 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _midPoint,
            initialZoom: 13.0,
            onMapReady: () {
              Future.delayed(const Duration(milliseconds: 300), _fitBounds);
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.technovicinity.technovicinity',
            ),
            PolylineLayer(
              polylines: [
                Polyline(
                  points: [_pointA, _pointB],
                  color: const Color(0xFF0066FF),
                  strokeWidth: 5.0,
                ),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _pointA,
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.my_location_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Marker(
                  point: _pointB,
                  width: 40,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF44336),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle_rounded,
                        color: Color(0xFF4CAF50), size: 10),
                    const SizedBox(width: 6),
                    Text(
                      widget.userData.routeNameA,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle_rounded,
                        color: Color(0xFFF44336), size: 10),
                    const SizedBox(width: 6),
                    Text(
                      widget.userData.routeNameB,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 16,
          right: 12,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Re-center / fit both points button
              FloatingActionButton.small(
                heroTag: 'fit_bounds_${widget.isFullScreen}',
                backgroundColor: Colors.white,
                elevation: 2,
                onPressed: _fitBounds,
                child: const Icon(Icons.fit_screen_rounded,
                    color: Color(0xFF0066FF), size: 20),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                heroTag: 'zoom_in_${widget.isFullScreen}',
                backgroundColor: Colors.white,
                elevation: 2,
                onPressed: _zoomIn,
                child: const Icon(Icons.add_rounded, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.small(
                heroTag: 'zoom_out_${widget.isFullScreen}',
                backgroundColor: Colors.white,
                elevation: 2,
                onPressed: _zoomOut,
                child: const Icon(Icons.remove_rounded, color: Colors.black87),
              ),
            ],
          ),
        ),

        Positioned(
          bottom: 12,
          left: 12,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'A: ${_pointA.latitude.toStringAsFixed(4)}, ${_pointA.longitude.toStringAsFixed(4)}'
              '   →   '
              'B: ${_pointB.latitude.toStringAsFixed(4)}, ${_pointB.longitude.toStringAsFixed(4)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
