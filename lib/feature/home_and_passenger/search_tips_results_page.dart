import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/result_and_booking/widget/filter_widget.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/home_and_passenger/passenger_trip_details.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

part 'widgets/search_trips_result_widgets.dart';

class SearchTipsResultsPage extends ConsumerWidget {
  const SearchTipsResultsPage({super.key, required this.request});
  final TripSearchRequest request;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(passengerTripsControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.results,
        actionWidget: InkWell(
          onTap: () {
            showFilterBottomSheet(context);
          },
          child: const Icon(Icons.filter_alt_rounded),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: state.items.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final trip = state.items[index];

                  return _SearchTripsResultCard(trip: trip);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
