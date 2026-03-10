// ignore_for_file: must_be_immutable

part of '../published_trip_details_view.dart';

class _BottomButtons extends StatefulWidget {
  final String driverId;
  final List<String> bookingIds;
  final TripsPublishController tripsPublishController;
  _BottomButtons({
    required this.bookingIds,
    required this.driverId,
    required this.tripsPublishController,
  });
  @override
  State<_BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<_BottomButtons> {
  Timer? _locationTimer;

  void startLocationUpdates() {
    _locationTimer?.cancel();

    _locationTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      driverUpdateLocation();
    });
  }

  void stopLocationUpdates() {
    _locationTimer?.cancel();
  }

  void driverUpdateLocation() async {
    final location = await getCurrentLocation();

    if (location == null) return;

    for (var element in widget.bookingIds) {
      widget.tripsPublishController.driverUpdateLocation(
        bookingId: element,
        driverId: widget.driverId,
        latitude: location.latitude,
        longitude: location.longitude,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startLocationUpdates();
  }

  @override
  void dispose() {
    log("dispose called=====");
    _locationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            AppLocalizations.of(context)!.cancel_trip,
            color: Colors.transparent,
            textColor: Colors.red,
            boarder: Border.all(color: Colors.red, width: 2),
            onTap: () {},
            height: 35,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CommonButton(
            AppLocalizations.of(context)!.start_trip,
            color: Colors.green,
            onTap: () {
              startLocationUpdates();
            },
            height: 35,
          ),
        ),
      ],
    );
  }
}
