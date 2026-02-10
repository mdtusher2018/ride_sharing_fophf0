import 'dart:math';
import 'dart:ui';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteResult {
  final Set<Polyline> polylines;
  final List<Route> routes;

  RouteResult(this.polylines, this.routes);
}

class MapHelper {
  static Future<RouteResult> drawRoutes({
    required String apiKey,
    required LatLng origin,
    required Color color,
    required LatLng destination,
  }) async {
    final polylinePoints = PolylinePoints(apiKey: apiKey);

    RoutesApiResponse result = await polylinePoints
        .getRouteBetweenCoordinatesV2(
          request: RoutesApiRequest(
            origin: PointLatLng(origin.latitude, origin.longitude),
            destination: PointLatLng(
              destination.latitude,
              destination.longitude,
            ),
            travelMode: TravelMode.driving,
            computeAlternativeRoutes: true,
          ),
        );

    if (result.routes.isEmpty) return RouteResult({}, []);

    Set<Polyline> polylines = {};

    for (int i = 0; i < result.routes.length; i++) {
      final route = result.routes[i];

      if (route.polylinePoints != null) {
        polylines.add(
          Polyline(
            polylineId: PolylineId("route_$i"),
            width: 5,
            color: color,
            points: route.polylinePoints!
                .map((p) => LatLng(p.latitude, p.longitude))
                .toList(),
          ),
        );
      }
    }

    return RouteResult(polylines, result.routes);
  }

  static void fitBounds(
    List<LatLng> points,
    GoogleMapController mapController,
  ) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (var p in points) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }

    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        60,
      ),
    );
  }

  static void moveCamera(LatLng position, GoogleMapController mapController) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 14),
      ),
    );
  }
}
