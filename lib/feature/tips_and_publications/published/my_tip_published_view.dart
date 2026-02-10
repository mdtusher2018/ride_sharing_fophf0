import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/enums_with_enum_extentions.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/tips_and_publications/published/my_published_details_view.dart';
import 'package:velozaje/models/response/trip/driver_published_trips.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/app_colors.dart';

class MyPublishedTripsPage extends ConsumerStatefulWidget {
  const MyPublishedTripsPage({super.key});

  @override
  ConsumerState<MyPublishedTripsPage> createState() =>
      _MyPublishedTripsPageState();
}

class _MyPublishedTripsPageState extends ConsumerState<MyPublishedTripsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(driverTripsControllerProvider.notifier).refresh();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(driverTripsControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(driverTripsControllerProvider);

    if (state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(16.w),
      itemCount: state.items.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final trip = state.items[index];

        return TripCard(trip: trip);
      },
    );
  }
}

class TripCard extends StatelessWidget {
  final DriverTripModel trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MyPublishedDetailsPage();
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.h),
        color: AppColors.white,
        shadowColor: Colors.black,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: trip.status.color().withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CommonText(
                      trip.status.label(context),
                      size: 12,
                      isBold: true,
                      color: trip.status.color(),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 20),
                      SizedBox(width: 6.w),
                      CommonText(formatDateTime(trip.departureTime), size: 12),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              /// From - To
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.radio_button_checked, size: 14),
                      SizedBox(height: 6),
                      Container(
                        width: 1,
                        height: 30,
                        color: AppColors.textPrimary,
                      ),
                      SizedBox(height: 6),
                      Icon(Icons.location_on, size: 18),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          AppLocalizations.of(context)!.from,
                          size: 11,
                          color: Colors.grey,
                        ),
                        CommonText(
                          trip.pickupLocation.address,
                          size: 13,
                          maxline: 1,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10.h),
                        CommonText(
                          AppLocalizations.of(context)!.to,
                          size: 11,
                          color: Colors.grey,
                        ),
                        CommonText(
                          trip.dropoffLocation.address,
                          size: 13,
                          maxline: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  CommonText(
                    formatDurationInMinutes(trip.estimatedDuration.toInt()),
                    size: 11,
                    color: Colors.grey,
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TripStat(
                      value: '${trip.bookedSeats}/${trip.totalSeats}',
                      label: AppLocalizations.of(context)!.seats,
                    ),
                    _Divider(),
                    _TripStat(
                      value: '\$${trip.pricePerSeat}',
                      label: AppLocalizations.of(context)!.seats,
                      valueColor: AppColors.primary,
                    ),
                    _Divider(),
                    _TripStat(
                      value: 'N/A',
                      label: AppLocalizations.of(context)!.requests,
                      valueColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripStat extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;

  const _TripStat({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonText(
          value,
          size: 16,
          fontWeight: FontWeight.w600,
          color: valueColor ?? AppColors.textPrimary,
        ),
        CommonText(label, size: 11, color: AppColors.textSecondary),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 30.h, color: AppColors.textPrimary);
  }
}
