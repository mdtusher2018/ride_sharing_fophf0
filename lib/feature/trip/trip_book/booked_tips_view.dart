part of '../trips_view.dart';

class BookedTipsPage extends ConsumerStatefulWidget {
  const BookedTipsPage({super.key});

  @override
  ConsumerState<BookedTipsPage> createState() => _MyTipsPageState();
}

class _MyTipsPageState extends ConsumerState<BookedTipsPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(tripsBookingControllerProvider.notifier).refresh();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 200) {
        ref.read(tripsBookingControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pagination = ref.watch(tripsBookingControllerProvider);
    final notifier = ref.read(tripsBookingControllerProvider.notifier);
    return ValueListenableBuilder(
      valueListenable: notifier.isLoading,
      builder: (_, isLoading, _) {
        if (isLoading && pagination.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (pagination.items.isEmpty) {
          return EmptyStateWidget(
            icon: Icons.calendar_month_outlined,
            title: "No Bookings Yet",
            description: "Your bookings will appear here once you make one.",
            buttonText: "Refresh",
            onButtonPressed: () {
              notifier.refresh();
            },
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            notifier.refresh();
          },
          child: ListView.builder(
            itemCount: pagination.items.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BookedTipDetailsView(
                          id: pagination.items[index].id,
                        );
                      },
                    ),
                  );
                },
                child: _MyTipCard(booking: pagination.items[index]),
              );
            },
          ),
        );
      },
    );
  }
}

class _MyTipCard extends StatelessWidget {
  const _MyTipCard({required this.booking});
  final PassengerBookingModel booking;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            status(booking.status),
            SizedBox(height: 8.h),
            _header(),
            SizedBox(height: 12.h),
            _verticalStepper(context),
            SizedBox(height: 12.h),
            Divider(),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(AppLocalizations.of(context)!.start_code),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonText(
                      booking.pickupOTP,
                      size: 16,
                      color: AppColors.primary,
                      isBold: true,
                    ),
                    CommonText(
                      AppLocalizations.of(context)!.give_at_pickup,
                      size: 10,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget status(BookingStatus status) {
    final Color color;

    switch (status) {
      case BookingStatus.confirmed:
        color = const Color(0xff28A745); // Green
        break;

      case BookingStatus.pending:
        color = const Color(0xffB59100); // Yellow
        break;

      case BookingStatus.inProgress:
        color = const Color(0xff007BFF); // Blue
        break;

      case BookingStatus.arrived:
        color = const Color.fromARGB(164, 108, 117, 125); // Grey
        break;

      case BookingStatus.completed:
        color = const Color(0xff6C757D); // Grey
        break;

      case BookingStatus.cancelled:
        color = const Color(0xffB50000); // Red
        break;

      case BookingStatus.unknown:
        color = const Color(0xff999999); // Light Grey
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: CommonText(status.name, color: color, size: 12),
        ),
        CommonText(
          formatDateTime(booking.bookingDate),
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _header() {
    return Row(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8, right: 10),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: CommonImage(
                  path: getFullImagePath(booking.driver.image ?? ""),
                  width: 50,
                  sourceType: ImageSourceType.network,
                  height: 50,
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
                booking.driver.fullName,
                size: 14,
                isBold: true,
                maxline: 1,
              ),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange),
                  SizedBox(width: 4),
                  CommonText(
                    (booking.driver.rating ?? 0).toStringAsFixed(1),
                    size: 12,
                  ),
                ],
              ),
              CommonText("\$${booking.totalPrice}", size: 16, isBold: true),
            ],
          ),
        ),
        Card(
          elevation: 2,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.email, color: AppColors.primary),
          ),
        ),
        Card(
          elevation: 2,
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(Icons.person_2, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  /// Vertical Stepper
  Widget _verticalStepper(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Column(
            children: [
              _stepDot(isActive: true),
              Container(width: 2, height: 40, color: Colors.grey),
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
                value: booking.pickupLocation.address,
              ),
              SizedBox(height: 10.h),
              _stepText(
                title: AppLocalizations.of(context)!.to,
                value: booking.dropoffLocation.address,
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
            formatDurationInMinutes(booking.trip.estimatedDuration),
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
