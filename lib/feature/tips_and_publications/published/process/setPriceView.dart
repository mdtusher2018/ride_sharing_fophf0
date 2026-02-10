part of 'publish_process_view.dart';

class SetPriceView extends StatefulWidget {
  final Function(double?, String?) onContinue;
  const SetPriceView({super.key, required this.onContinue});

  @override
  State<SetPriceView> createState() => _SetPriceViewState();
}

class _SetPriceViewState extends State<SetPriceView> {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController tripDetailsController = TextEditingController();

  bool automaticReservation = false;

  @override
  void dispose() {
    priceController.dispose();
    tripDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            /// Drag Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            CommonText(
              AppLocalizations.of(context)!.set_your_price,
              size: 18,
              isBold: true,
            ),
            SizedBox(height: 8.h),

            CommonText(
              AppLocalizations.of(context)!.price_per_seat,
              size: 12,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 6.h),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixText: "\$ ",
              ),
            ),

            SizedBox(height: 16.h),

            /// Trip Details
            CommonText(
              AppLocalizations.of(context)!.trip_details,
              isBold: true,
            ),
            SizedBox(height: 8.h),

            CommonTextfieldWithTitle(
              AppLocalizations.of(context)!.trip_details,
              tripDetailsController,
              maxLine: 3,
              hintText: AppLocalizations.of(
                context,
              )!.lorem_ipsum_is_simply_dummy_text_of_the_printing_and_typesetting_industry_lorem_ipsum,
            ),

            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  AppLocalizations.of(context)!.automatic_reservation,
                  fontWeight: FontWeight.w500,
                  size: 14,
                ),
                Switch(
                  value: automaticReservation,
                  activeColor: AppColors.primary,
                  onChanged: (val) {
                    setState(() {
                      automaticReservation = val;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 24.h),

            CommonButton(
              AppLocalizations.of(context)!.continue_text,
              height: 44,
              onTap: () {
                widget.onContinue(
                  double.tryParse(priceController.text.trim()),
                  tripDetailsController.text.trim(),
                );
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
