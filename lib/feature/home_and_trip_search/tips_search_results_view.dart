import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/home_and_trip_search/parts_of_trip_search/filter_widget.dart';
import 'package:velozaje/models/request/trip_search_request.dart';
import 'package:velozaje/models/response/trip/passenger_trip_model.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/core/utils/helper.dart';
import 'package:velozaje/feature/home_and_trip_search/trip_details.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

part 'parts_of_trip_search/trips_search_result_widgets.dart';

class TipsSearchResultsView extends ConsumerStatefulWidget {
  const TipsSearchResultsView({super.key, required this.request});
  final TripSearchRequest request;

  @override
  ConsumerState<TipsSearchResultsView> createState() =>
      _TipsSearchResultsViewState();
}

class _TipsSearchResultsViewState extends ConsumerState<TipsSearchResultsView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(passengerTripsControllerProvider.notifier).refresh();
    });

    final controller = ref.read(passengerTripsControllerProvider.notifier);
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pagination = ref.watch(passengerTripsControllerProvider);
    final notifier = ref.read(passengerTripsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.results,
        actionWidget: InkWell(
          onTap: () {
            showFilterBottomSheet(ref);
          },
          child: const Icon(Icons.filter_alt_rounded),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: notifier.isLoading,
        builder: (_, isLoading, _) {
          if (isLoading && pagination.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (pagination.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off, size: 48, color: Colors.grey),
                  SizedBox(height: 10),
                  CommonText("No trips found"),
                  SizedBox(height: 4),
                  CommonText("Please try again later"),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16.w),
            child: ListView.separated(
              controller: scrollController,
              itemCount: pagination.items.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final trip = pagination.items[index];

                return _SearchTripsResultCard(
                  trip: trip,
                  bookingTripSearched: widget.request,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
