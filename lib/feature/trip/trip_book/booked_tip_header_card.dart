// ignore_for_file: must_be_immutable

part of 'booked_tip_details_view.dart';

class TipHeaderCard extends StatelessWidget {
  TipHeaderCard({super.key, required this.bookingDetails});

  final PassengerBookingDetailsModel bookingDetails;
  bool isstart = false;

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
          securityHandShake(context),
          SizedBox(height: 12.h),
          _header(context),
          SizedBox(height: 12.h),
          _verticalStepper(context),
          SizedBox(height: 12.h),
          Divider(),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              AppLocalizations.of(context)!.trip_details,
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: CommonText(
              bookingDetails.trip.description,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget securityHandShake(BuildContext context) {
    final int length = 4;

    // List<TextEditingController> controllers = List.generate(
    //   length,
    //   (_) => TextEditingController(),
    // );
    List<FocusNode> focusNodes = List.generate(length, (_) => FocusNode());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNodes.first.requestFocus();
    });

    return Container(
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              spacing: 8.w,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.grey,
                  size: 20,
                ),
                CommonText(
                  AppLocalizations.of(context)!.security_handshake,
                  color: AppColors.textSecondary,
                ),
              ],
            ),

            Divider(),

            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8.h,

                      children: [
                        CommonText(
                          AppLocalizations.of(context)!.start_code,
                          color: AppColors.white,
                          size: 12,
                        ),
                        if (bookingDetails.status == BookingStatus.pending)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                              4,
                              (index) => Container(
                                padding: EdgeInsets.all(4),
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.primary,
                                  ),
                                ),

                                child: Icon(Icons.lock_outline),
                              ),
                            ),
                          ),

                        if (bookingDetails.status != BookingStatus.pending) ...[
                          Stack(
                            alignment: AlignmentGeometry.center,
                            children: [
                              CommonText(
                                bookingDetails.pickupOTP.toString(),
                                size: 18,
                                letterSpacing: 6,
                                color: AppColors.textSecondary,
                                isBold: true,
                              ),
                              if ((bookingDetails.status !=
                                  BookingStatus.confirmed))
                                Container(
                                  height: 2,
                                  color: AppColors.textSecondary,
                                  width: 60.sp,
                                ),
                            ],
                          ),
                          CommonText(
                            AppLocalizations.of(context)!.give_at_pickup,
                            color: AppColors.grey,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Container(height: 60, width: 1, color: AppColors.grey),
                Expanded(
                  child: Column(
                    spacing: 8.h,
                    children: [
                      CommonText(
                        AppLocalizations.of(context)!.end_code,
                        size: 12,
                        color: Colors.white,
                      ),
                      if (bookingDetails.dropoffOTP == null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) => Container(
                              padding: EdgeInsets.all(4),
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 2,
                                  color: AppColors.primary,
                                ),
                              ),

                              child: Icon(Icons.lock_outline),
                            ),
                          ),
                        ),
                      if (bookingDetails.dropoffOTP != null) ...[
                        Stack(
                          alignment: AlignmentGeometry.center,
                          children: [
                            CommonText(
                              bookingDetails.dropoffOTP.toString(),
                              size: 18,
                              letterSpacing: 6,
                              color: AppColors.textSecondary,
                              isBold: true,
                            ),
                            if ((bookingDetails.status ==
                                BookingStatus.completed))
                              Container(
                                height: 2,
                                color: AppColors.textSecondary,
                                width: 60.sp,
                              ),
                          ],
                        ),
                        CommonText(
                          "${AppLocalizations.of(context)!.give_to} ${bookingDetails.driver.fullName}",
                          color: AppColors.grey,
                          maxline: 1,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            if (bookingDetails.status == BookingStatus.pending)
              CommonText(
                "Booked not confirm by driver yet...",
                size: 12,
                color: AppColors.white,
              ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6, bottom: 6),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8),
                child: CommonImage(
                  path: bookingDetails.driver.image,
                  width: 60,
                  height: 60,
                  sourceType: ImageSourceType.network,
                ),
              ),
            ),
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
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                bookingDetails.driver.fullName,
                size: 14,
                maxline: 1,
                isBold: true,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText(
                    bookingDetails.driver.rating.toStringAsFixed(1),
                    size: 12,
                  ),
                ],
              ),
              CommonText(
                "\$${bookingDetails.trip.pricePerSeat.toStringAsFixed(1)}",
                size: 16,
                isBold: true,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage(
                    reciverId: bookingDetails.driver.id,
                    reciverImage: bookingDetails.driver.image ?? "",
                    reciverName: bookingDetails.driver.fullName,
                    bookingId: bookingDetails.id,
                  );
                },
              ),
            );
          },
          child: Card(
            elevation: 2,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.email, color: AppColors.primary),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return DriverProfileView(
                    id: bookingDetails.driver.id,
                    tripId: bookingDetails.trip.id,
                    bookingId: bookingDetails.id,
                  );
                },
              ),
            );
          },
          child: Card(
            elevation: 2,
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.person_2, color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _verticalStepper(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              Icon(Icons.radio_button_checked),
              Container(width: 2, height: 40, color: Colors.grey),
              Icon(Icons.location_on_outlined),
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
                value: bookingDetails.pickupLocation.address,
              ),
              SizedBox(height: 10.h),
              _stepText(
                title: AppLocalizations.of(context)!.to,
                value: bookingDetails.dropoffLocation.address,
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
            formatDurationInMinutes(bookingDetails.trip.estimatedDuration),
            size: 10,
          ),
        ),
      ],
    );
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
}
