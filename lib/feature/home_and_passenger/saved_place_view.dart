import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/providers.dart';
import 'package:velozaje/feature/home_and_passenger/widgets/saved_place_card.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';

class SavedPlacePage extends ConsumerStatefulWidget {
  const SavedPlacePage({super.key});

  @override
  ConsumerState<SavedPlacePage> createState() => _SavedPlacePageState();
}

class _SavedPlacePageState extends ConsumerState<SavedPlacePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(savedLocationProvider.notifier).getSavedLocations();
    });
  }

  Future<void> _onRefresh() async {
    await ref.read(savedLocationProvider.notifier).getSavedLocations();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(savedLocationProvider);

    return Scaffold(
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.saved_places,
      ),
      backgroundColor: AppColors.mainbg,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.primary,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: ValueListenableBuilder(
            valueListenable: ref
                .watch(savedLocationProvider.notifier)
                .isLoading,
            builder: (context, value, child) {
              return value
                  ? const Center(child: CircularProgressIndicator())
                  : state.savedPlaces.isEmpty
                  ? _EmptySavedPlaces()
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemCount: state.savedPlaces.length,
                      itemBuilder: (context, index) {
                        return savedPlaceCard(
                          savedLocationModel: state.savedPlaces[index],
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _EmptySavedPlaces extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 80.h),
          Icon(
            Icons.bookmark_border,
            size: 72.sp,
            color: AppColors.grey.withOpacity(0.5),
          ),
          SizedBox(height: 8.h),
          Text(
            "No saved Location",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: CommonButton(
              "Refresh",
              onTap: ref.read(savedLocationProvider.notifier).getSavedLocations,
              height: 40,
              textSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
