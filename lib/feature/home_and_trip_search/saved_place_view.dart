import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/feature/home_and_trip_search/widgets/saved_place_card.dart';
import 'package:velozaje/feature/widget/no_data.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field.dart';
import 'package:velozaje/res/location_search_textfield.dart';

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
                  ? EmptyStateWidget(
                      icon: Icons.location_off,
                      title: "No Saved Locations",
                      description: "You haven't saved any locations yet.",
                      buttonText: "Refresh Locations",
                      onButtonPressed: () async {
                        ref
                            .read(savedLocationProvider.notifier)
                            .getSavedLocations();
                      },
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemCount: state.savedPlaces.length,
                      itemBuilder: (context, index) {
                        return savedPlaceCard(
                          savedLocationModel: state.savedPlaces[index],
                          onRemove: () {
                            ref
                                .read(savedLocationProvider.notifier)
                                .removeSaveLocation(
                                  id: state.savedPlaces[index].id,
                                );
                          },
                        );
                      },
                    );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddLocationDialog,
        shape: CircleBorder(),
        backgroundColor: AppColors.primary,
        child: Icon(Icons.add, color: AppColors.mainbg),
      ),
    );
  }

  void _showAddLocationDialog() {
    final TextEditingController addressController = TextEditingController();
    final TextEditingController placeNameController = TextEditingController();
    LatLng? selectedLatLng;

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          title: CommonText(
            AppLocalizations.of(context)!.saved_places,
            size: 16,
            isBold: true,
          ),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Place Name Field
                  CommonTextField(
                    controller: placeNameController,
                    hintText: AppLocalizations.of(context)!.place_name,
                  ),

                  SizedBox(height: 16.h),

                  /// Location Search Field
                  LocationSearchField(
                    hint: AppLocalizations.of(context)!.enter_your_address,
                    controller: addressController,
                    onAddressSelected: (location, latlng) {
                      selectedLatLng = latlng;
                      addressController.text = location;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: CommonText(AppLocalizations.of(context)!.cancel),
            ),
            SizedBox(
              height: 36,
              child: CommonButton(
                AppLocalizations.of(context)!.save,
                onTap: () async {
                  await ref
                      .read(savedLocationProvider.notifier)
                      .saveLocation(
                        address: addressController.text.trim(),
                        latlng: selectedLatLng,
                        placeName: placeNameController.text.trim(),
                        onSucess: (value) {
                          if (value) {
                            Navigator.pop(context);
                          }
                        },
                      );
                },
                textSize: 14,
                boarderRadious: 8,
                width: 60,
                height: 30,
              ),
            ),
          ],
        );
      },
    );
  }
}
