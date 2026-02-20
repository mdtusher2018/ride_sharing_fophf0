import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/core/utils/map_helper.dart';
import 'package:velozaje/feature/home_and_trip_search/saved_place_view.dart';
import 'package:velozaje/feature/home_and_trip_search/searching_drivers_view.dart';

import 'package:velozaje/feature/home_and_trip_search/widgets/saved_place_card.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/notifications/notifications_view.dart';
import 'package:velozaje/feature/widget/date_time_picker.dart';
import 'package:velozaje/feature/widget/map_widget.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/location_search_textfield.dart';

part 'parts_of_home/home_page_widgets.dart';
part 'parts_of_home/home_page_utils.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isTravelSelected = true;

  final TextEditingController dateTimeController = TextEditingController();

  DateTime? dateTime;

  (TextEditingController, LatLng?) destination = (
    TextEditingController(),
    null,
  );
  (TextEditingController, LatLng?) pickup = (TextEditingController(), null);

  Set<Polyline> _polylines = {};
  GoogleMapController? _mapController;

  void _initialize() async {
    await ref
        .read(notificationsControllerProvider.notifier)
        .unreadNotificationCount();
    await ref.read(savedLocationProvider.notifier).getSavedLocations();
    _initializedController(count);
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _onPickupSelected(String address, LatLng latLng) {
    if (_mapController == null) return;
    setState(() {
      pickup.$1.text = address;
      pickup = (pickup.$1, latLng);
    });
    MapHelper.moveCamera(latLng, _mapController!);
    _drawRoutesIfReady();
  }

  void _onDestinationSelected(String address, LatLng latLng) {
    if (_mapController == null) return;
    setState(() {
      destination.$1.text = address;
      destination = (destination.$1, latLng);
    });
    MapHelper.moveCamera(latLng, _mapController!);
    _drawRoutesIfReady();
  }

  Future<void> _drawRoutesIfReady() async {
    if (_mapController == null || pickup.$2 == null || destination.$2 == null) {
      return;
    }

    final result = await MapHelper.drawRoutes(
      origin: pickup.$2!,
      color: AppColors.primary,
      destination: destination.$2!,
    );

    if (result.polylines.isEmpty || result.routes.isEmpty) return;

    setState(() {
      _polylines = result.polylines;
    });

    MapHelper.fitBounds(result.polylines.first.points, _mapController!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ReusableMapWidget(
            context: context,
            pickupLocation: pickup.$2,
            destinationLocation: destination.$2,
            polylines: _polylines,
            initialZoom: 12.0,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          topBar(context, ref),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            minChildSize: 0.18,
            maxChildSize: 0.65,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.all(16.w),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: SingleChildScrollView(
                  controller: scrollController, // 🔑 IMPORTANT
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Handle
                      Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      /// Travel / Send Package Tabs
                      Container(
                        height: 45.h,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            tabButton(
                              AppLocalizations.of(context)!.travel,
                              isTravelSelected,
                              () {
                                count = 0;
                                setState(() => isTravelSelected = true);
                              },
                            ),
                            tabButton(
                              AppLocalizations.of(context)!.send_package,
                              !isTravelSelected,
                              () {
                                count = 0;
                                setState(() => isTravelSelected = false);
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),
                      LocationSearchField(
                        hint: AppLocalizations.of(context)!.pick_up_location,
                        controller: pickup.$1,

                        onAddressSelected: _onPickupSelected,
                      ),

                      SizedBox(height: 12.h),
                      LocationSearchField(
                        hint: AppLocalizations.of(context)!.destination,
                        controller: destination.$1,
                        enableCurrentLocation: false,
                        onAddressSelected: _onDestinationSelected,
                      ),

                      SizedBox(height: 12.h),

                      Row(
                        spacing: 12,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                final DateTime? result =
                                    await showDateTimePickerDialog(context);

                                if (result != null) {
                                  setState(() {
                                    dateTime = result;
                                    dateTimeController.text =
                                        "${result.day}/${result.month}/${result.year}";
                                  });
                                }
                              },
                              child: infoBox(
                                Icons.calendar_month,
                                (dateTimeController.text.isNotEmpty)
                                    ? dateTimeController.text
                                    : AppLocalizations.of(context)!.time_date,
                              ),
                            ),
                          ),

                          Expanded(
                            child: isTravelSelected
                                ? _counterBoxForPerson(
                                    onDecrease: () {
                                      setState(() => count--);
                                    },
                                    onIncrease: () {
                                      setState(() => count++);
                                    },
                                  )
                                : _counterBoxForPackage(
                                    onDecrease: () {
                                      setState(() {
                                        count--;
                                      });
                                    },
                                    onIncrease: () {
                                      setState(() {
                                        count++;
                                      });
                                    },
                                  ),
                          ),
                        ],
                      ),

                      if (!isTravelSelected) ...[
                        SizedBox(height: 12.h),

                        ListView.separated(
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10.h);
                          },
                          shrinkWrap: true,
                          itemCount: count,
                          itemBuilder: (context, index) {
                            return weightCard(index, context);
                          },
                        ),
                      ],

                      SizedBox(height: 16.h),

                      ValueListenableBuilder(
                        valueListenable: ref
                            .watch(savedLocationProvider.notifier)
                            .isLoading,
                        builder: (context, value, child) {
                          return value
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(0),
                                  itemCount: min(
                                    ref
                                        .read(savedLocationProvider)
                                        .savedPlaces
                                        .length,
                                    2,
                                  ),
                                  itemBuilder: (context, index) {
                                    return savedPlaceCard(
                                      savedLocationModel: ref
                                          .read(savedLocationProvider)
                                          .savedPlaces[index],
                                      onRemove: () {
                                        ref
                                            .read(
                                              savedLocationProvider.notifier,
                                            )
                                            .removeSaveLocation(
                                              id: ref
                                                  .read(savedLocationProvider)
                                                  .savedPlaces[index]
                                                  .id,
                                            );
                                      },
                                    );
                                  },
                                );
                        },
                      ),

                      SizedBox(height: 10.h),
                      savedPlaceButtonCard(context),
                      SizedBox(height: 20.h),

                      /// Search Button
                      CommonButton(
                        AppLocalizations.of(context)!.search_trips,
                        onTap: () {
                          final isValid = validateTripSearch(
                            context: context,
                            pickup: pickup,
                            destination: destination,
                            dateTime: dateTime,
                            isTravelSelected: isTravelSelected,
                            count: count,
                            packageControllers: packageControllers,
                          );

                          if (!isValid) return;
                          final packages = isTravelSelected
                              ? <PackageItem>[]
                              : packageControllers.map((c) {
                                  return PackageItem(
                                    weightKg:
                                        double.tryParse(c.weight.text) ?? 0,
                                    lengthCm:
                                        double.tryParse(c.length.text) ?? 0,
                                    widthCm: double.tryParse(c.width.text) ?? 0,
                                    heightCm:
                                        double.tryParse(c.height.text) ?? 0,
                                  );
                                }).toList();

                          final request = TripSearchRequest(
                            bookingType: isTravelSelected
                                ? BookingType.travel
                                : BookingType.package,
                            pickupLatLng: pickup.$2,
                            pickupAddress: pickup.$1.text,
                            destinationLatLng: destination.$2,
                            destinationAddress: destination.$1.text,
                            departureTime: dateTime!,
                            passengersCount: isTravelSelected ? count : 0,
                            packages: packages,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SearchingDriversView(
                                request: request, // 👈 SINGLE MODEL
                              ),
                            ),
                          );
                        },

                        height: 40,
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
