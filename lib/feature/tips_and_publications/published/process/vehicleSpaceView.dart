part of 'publish_process_view.dart';

class VehicleSpaceView extends ConsumerStatefulWidget {
  final void Function(String vehicleId, int? totalSeats) onContinue;

  const VehicleSpaceView({super.key, required this.onContinue});

  @override
  ConsumerState<VehicleSpaceView> createState() => _VehicleSpaceViewState();
}

class _VehicleSpaceViewState extends ConsumerState<VehicleSpaceView> {
  bool enablePackageDelivery = true;
  final TextEditingController _seatsController = TextEditingController();

  @override
  void dispose() {
    _seatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleData = ref.watch(vehicaleControllerProvider).vehicale;

    return Container(
      padding: EdgeInsets.all(16.w),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.75,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              AppLocalizations.of(context)!.vehicle_space,
              size: 18,
              isBold: true,
            ),
            SizedBox(height: 12.h),
            (vehicleData == null)
                ? const Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  )
                : VehicleCard(
                    brand: vehicleData.brand,
                    image: vehicleData.vehicleImages.first,
                    licensePlateNumber: vehicleData.licensePlateNumber,
                    vehicleModel: vehicleData.vehicleModel,
                    year: vehicleData.year.toString(),
                  ),
            SizedBox(height: 16.h),

            // Empty Seats
            CommonText(AppLocalizations.of(context)!.empty_seats, isBold: true),
            SizedBox(height: 8.h),
            TextField(
              controller: _seatsController,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 21),
              decoration: const InputDecoration(
                hintText: "04",
                hintStyle: TextStyle(fontSize: 21),
              ),
            ),

            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  AppLocalizations.of(context)!.enable_package_delivery,
                  fontWeight: FontWeight.w500,
                  size: 14,
                ),
                Switch(
                  value: enablePackageDelivery,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() {
                      enablePackageDelivery = val;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 30.h),
            CommonButton(
              AppLocalizations.of(context)!.continue_text,
              disable: vehicleData == null || !_isSeatsValid(),
              height: 44,
              onTap: () {
                if (vehicleData == null) return;
                final totalSeats = int.tryParse(_seatsController.text);
                widget.onContinue(vehicleData.id, totalSeats);
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  bool _isSeatsValid() {
    final seats = int.tryParse(_seatsController.text);
    return seats != null && seats > 0;
  }
}
