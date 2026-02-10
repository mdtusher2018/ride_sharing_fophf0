part of 'publish_process_view.dart';

class PublishFormView extends StatefulWidget {
  final Function(DateTime?) onContinue;
  final (TextEditingController, LatLng?) pickup;
  final (TextEditingController, LatLng?) destination;
  final Function(String, LatLng) onPickupSelected;
  final Function(String, LatLng) onDestinationSelected;

  const PublishFormView({
    super.key,
    required this.onContinue,
    required this.pickup,
    required this.destination,
    required this.onPickupSelected,
    required this.onDestinationSelected,
  });

  @override
  State<PublishFormView> createState() => _PublishFormViewState();
}

class _PublishFormViewState extends State<PublishFormView> {
  final TextEditingController dateTimeController = TextEditingController();
  DateTime? dateTime;

  @override
  void dispose() {
    widget.pickup.$1.dispose();
    widget.destination.$1.dispose();
    dateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CommonText(
                AppLocalizations.of(context)!.where_are_you_going,
                size: 18,
                isBold: true,
              ),
            ),

            LocationSearchField(
              hint: AppLocalizations.of(context)!.pick_up_location,
              controller: widget.pickup.$1,
              onAddressSelected: widget.onPickupSelected,
            ),

            LocationSearchField(
              hint: AppLocalizations.of(context)!.destination,
              controller: widget.destination.$1,
              enableCurrentLocation: false,
              onAddressSelected: widget.onDestinationSelected,
            ),

            InkWell(
              onTap: () async {
                final DateTime? result = await showDateTimePickerDialog(
                  context,
                );

                if (result != null) {
                  setState(() {
                    dateTime = result;
                    dateTimeController.text =
                        "${result.day}/${result.month}/${result.year} "
                        "${result.hour}:${result.minute.toString().padLeft(2, '0')}";
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.grey),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CommonText(
                        dateTimeController.text.isNotEmpty
                            ? dateTimeController.text
                            : AppLocalizations.of(context)!.time_date,
                        size: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            CommonButton(
              AppLocalizations.of(context)!.continue_text,
              height: 40,
              onTap: () {
                widget.onContinue(dateTime);
              },
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
