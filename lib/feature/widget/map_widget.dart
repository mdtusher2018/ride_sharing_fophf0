import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/utils/defult_values.dart';

Widget ReusableMapWidget({
  required BuildContext context,
  LatLng? pickupLocation,
  LatLng? destinationLocation,
  Set<Polyline>? polylines,
  double initialZoom = 10.0,
  Function(GoogleMapController)? onMapCreated,
}) {
  return GoogleMap(
    initialCameraPosition: CameraPosition(
      target: AppDefaultValue.latLng,
      zoom: initialZoom,
    ),
    polylines: polylines ?? <Polyline>{},
    onMapCreated: (controller) {
      if (onMapCreated != null) {
        onMapCreated(controller);
      }
    },
    markers: _buildMarkers(
      pickupLocation: pickupLocation,
      destinationLocation: destinationLocation,
    ),
  );
}

Set<Marker> _buildMarkers({
  LatLng? pickupLocation,
  LatLng? destinationLocation,
}) {
  final markers = <Marker>{};

  if (pickupLocation != null) {
    markers.add(
      Marker(
        markerId: const MarkerId('pickup'),
        position: pickupLocation,
        infoWindow: const InfoWindow(title: 'Pickup Location'),
      ),
    );
  }

  if (destinationLocation != null) {
    markers.add(
      Marker(
        markerId: const MarkerId('dropoff'),
        position: destinationLocation,
        infoWindow: const InfoWindow(title: 'Dropoff Location'),
      ),
    );
  }

  return markers;
}
