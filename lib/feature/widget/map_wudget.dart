import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/utils/defult_values.dart';

class ReusableMapWidget extends StatelessWidget {
  final LatLng? pickupLocation;
  final LatLng? destinationLocation;
  final Set<Polyline>? polylines; // Optional, for custom polylines
  final double initialZoom;
  final Function? onMapCreated;

  const ReusableMapWidget({
    super.key,
    this.pickupLocation,
    this.destinationLocation,
    this.polylines,
    this.initialZoom = 10.0,
    this.onMapCreated,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: AppDefaultValue.latLng,
        zoom: initialZoom,
      ),
      polylines: polylines ?? <Polyline>{},
      onMapCreated: (controller) {
        if (onMapCreated != null) onMapCreated!(controller);
      },
      markers: _buildMarkers(),
    );
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};

    if (pickupLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickupLocation!,
          infoWindow: const InfoWindow(title: 'Pickup Location'),
        ),
      );
    }

    if (destinationLocation != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('dropoff'),
          position: destinationLocation!,
          infoWindow: const InfoWindow(title: 'Dropoff Location'),
        ),
      );
    }

    return markers;
  }
}
