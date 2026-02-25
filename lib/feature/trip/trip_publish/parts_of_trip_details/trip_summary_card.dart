part of '../published_trip_details_view.dart';

class _TripSummaryCard extends StatelessWidget {
  final PassengerTripModel trip;
  const _TripSummaryCard({required this.trip});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xff111827),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CommonText(
                  trip.status,
                  size: 12,
                  color: AppColors.primary,
                ),
              ),
              const Spacer(),
              CommonText(
                '\$${trip.pricePerSeat * trip.bookedSeats}',
                size: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ],
          ),

          Row(
            spacing: 16.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CommonText(
                  '${trip.pickupLocation.address} to ${trip.dropoffLocation.address}',
                  size: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              CommonText(
                AppLocalizations.of(context)!.earning,
                color: AppColors.white,
              ),
            ],
          ),

          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoBox(
                icon: Icons.person_2_outlined,
                value: '${trip.bookedSeats}/${trip.totalSeats}',
                label: AppLocalizations.of(context)!.passengers,
              ),
              _InfoBox(
                icon: Iconsax.box_1_outline,
                value: trip.packageDeliveryEnabled
                    ? trip.packages.length.toString()
                    : '0',
                label: AppLocalizations.of(context)!.packages,
              ),
              _InfoBox(
                icon: Iconsax.send_2_outline,
                value: formatDurationInMinutes(trip.estimatedDuration.toInt()),
                label: AppLocalizations.of(context)!.est_time,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoBox({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(height: 6.h),
          CommonText(value, color: Colors.white, fontWeight: FontWeight.bold),
          CommonText(label, size: 10, color: Colors.white70),
        ],
      ),
    );
  }
}
