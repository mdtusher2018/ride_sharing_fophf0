import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/res/common_text.dart';

class LocationSearchField extends StatefulWidget {
  final String hint;
  final String title;
  final Color iconColor;
  final ValueChanged<String>? onAddressSelected;
  final ValueChanged<LatLng>? onLatLngSelected;
  final bool enableCurrentLocation;
  final TextEditingController controller;

  const LocationSearchField({
    super.key,
    required this.hint,
    required this.title,
    this.iconColor = AppColors.primary,
    this.onAddressSelected,
    this.onLatLngSelected,
    this.enableCurrentLocation = true,
    required this.controller,
  });

  @override
  State<LocationSearchField> createState() => _LocationSearchFieldState();
}

class _LocationSearchFieldState extends State<LocationSearchField> {
  Future<void> _getCurrentLocation() async {
    final position = await getCurrentLocation();
    if (position == null) return;

    final latLng = LatLng(position.latitude, position.longitude);

    widget.controller.text = "Current Location";

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      widget.controller.text =
          "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    }

    widget.onAddressSelected?.call(widget.controller.text);
    widget.onLatLngSelected?.call(latLng);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(widget.title, size: 14, isBold: true),
        SizedBox(height: 8),
        GooglePlaceAutoCompleteTextField(
          textEditingController: widget.controller,
          googleAPIKey: ApiEndpoints.mapKey,
          debounceTime: 600,
          isLatLngRequired: true,

          inputDecoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: Icon(Icons.location_on, color: AppColors.grey),
            suffixIcon: widget.enableCurrentLocation
                ? IconButton(
                    icon: Icon(Icons.my_location, color: widget.iconColor),
                    onPressed: _getCurrentLocation,
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),

          getPlaceDetailWithLatLng: (prediction) {
            final address = prediction.description ?? "";
            final latLng = LatLng(
              double.parse(prediction.lat!),
              double.parse(prediction.lng!),
            );

            widget.onAddressSelected?.call(address);
            widget.onLatLngSelected?.call(latLng);
          },
          focusNode: FocusNode(),
          itemClick: (prediction) {
            widget.controller.text = prediction.description ?? "";
            widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length),
            );
          },
        ),
      ],
    );
  }
}
