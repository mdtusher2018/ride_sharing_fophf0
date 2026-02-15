part of '../tips_search_results_view.dart';

class _SearchTripsResultCard extends StatefulWidget {
  final PassengerTripModel trip;
  final TripSearchRequest? bookingTripSearched;
  const _SearchTripsResultCard({
    required this.trip,
    required this.bookingTripSearched,
  });

  @override
  State<_SearchTripsResultCard> createState() => _SearchTripsResultCardState();
}

class _SearchTripsResultCardState extends State<_SearchTripsResultCard> {
  bool showPackageOptions = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _header(),
          SizedBox(height: 12.h),
          _verticalStepper(),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 10.h),
          if (showPackageOptions) _packageSelector(),
          if (!showPackageOptions) _footer(),
          if (showPackageOptions)
            CommonButton(
              AppLocalizations.of(context)!.view_details,
              height: 24,
              textSize: 14,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return PassengerTripDetailsPage(
                        tripId: widget.trip.id,
                        bookingTripSearched: widget.bookingTripSearched,
                      );
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  /// Header (Avatar + Name + Price)
  Widget _header() {
    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(right: 8, bottom: 4),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),
                child: CommonImage(
                  path: getFullImagePath(widget.trip.driverImage),
                  height: 50,
                  width: 50,
                ),
              ),
            ),
            if (widget.trip.driver != null && widget.trip.driver!.isActive)
              Positioned(
                bottom: 0,
                right: 0,
                child: Icon(
                  Icons.verified,
                  color: AppColors.primary,
                  shadows: [Shadow(color: Colors.white)],
                ),
              ),
          ],
        ),

        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.trip.driver != null)
                CommonText(
                  widget.trip.driver!.fullName,
                  size: 16,
                  isBold: true,
                ),
              Row(
                children: [
                  Icon(Icons.star, size: 24, color: Colors.orange),
                  SizedBox(width: 4),
                  if (widget.trip.driver != null)
                    CommonText(
                      widget.trip.driver!.ratting.toStringAsFixed(1),
                      size: 14,
                    ),
                ],
              ),
            ],
          ),
        ),
        CommonText(
          "\$${widget.trip.pricePerSeat.toStringAsFixed(0)}",
          size: 16,
          isBold: true,
        ),
      ],
    );
  }

  /// Vertical Stepper
  Widget _verticalStepper() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              _stepDot(isActive: true),
              _stepLine(),
              _stepLocation(isActive: false),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepText(
                title: AppLocalizations.of(context)!.from,
                value: widget.trip.pickupLocation.address,
              ),
              SizedBox(height: 10.h),
              _stepText(
                title: AppLocalizations.of(context)!.to,
                value: widget.trip.dropoffLocation.address,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.grey.withOpacity(.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: CommonText(
            formatDurationInMinutes(widget.trip.estimatedDuration.toInt()),
            size: 10,
          ),
        ),
      ],
    );
  }

  Widget _stepDot({required bool isActive}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: isActive ? 7 : 2.5),
      ),
    );
  }

  Widget _stepLocation({required bool isActive}) {
    return Icon(isActive ? Icons.location_on : Icons.location_on_outlined);
  }

  Widget _stepLine() {
    return Container(width: 2, height: 40, color: Colors.grey);
  }

  Widget _stepText({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(title, size: 11, color: Colors.grey),
        SizedBox(height: 2),
        CommonText(value, size: 13, isBold: true),
      ],
    );
  }

  Widget _packageSelector() {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          _sizeCard(AppLocalizations.of(context)!.small, "\$60"),
          SizedBox(width: 10.w),
          _sizeCard(AppLocalizations.of(context)!.medium, "\$00"),
          SizedBox(width: 10.w),
          _sizeCard(AppLocalizations.of(context)!.large, "\$00"),
        ],
      ),
    );
  }

  Widget _sizeCard(String title, String price) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(4.w),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Iconsax.box_1_outline),
              SizedBox(width: 6.h),
              CommonText(price, size: 14, isBold: true),
            ],
          ),
        ),
      ),
    );
  }

  /// Footer
  Widget _footer() {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: CommonText(
              widget.trip.vehicle?.vehicleModel ?? "",
              size: 10,
            ),
          ),
          const Spacer(),
          CommonButton(
            AppLocalizations.of(context)!.view_details,
            onTap: () {
              setState(() {
                showPackageOptions = !showPackageOptions;
              });
            },
            height: 30,
            width: 120,
            textSize: 14,
          ),
        ],
      ),
    );
  }
}
