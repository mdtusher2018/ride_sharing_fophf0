part of '../trips_publishing_view.dart';

class RouteSelectionView extends StatefulWidget {
  final Function(String?) onContinue;
  final List<Route> routes;
  final Function(int index)? onRouteSelected;

  const RouteSelectionView({
    super.key,
    required this.onContinue,
    required this.routes,
    required this.onRouteSelected,
  });

  @override
  _RouteSelectionViewState createState() => _RouteSelectionViewState();
}

class _RouteSelectionViewState extends State<RouteSelectionView> {
  int selectedRouteIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(widget.routes.length, (index) {
                final route = widget.routes[index];
                final distanceKm = ((route.distanceMeters ?? 0) / 1000);
                final durationMin = ((route.duration ?? 0) / 60).round();

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRouteIndex = index;
                      });

                      widget.onRouteSelected?.call(index);
                    },
                    child: _RouteTile(
                      isSelected: selectedRouteIndex == index,
                      distanceKm: distanceKm,
                      durationMin: durationMin,
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 16.h),

            CommonButton(
              AppLocalizations.of(context)!.continue_text,
              onTap: () {
                if (selectedRouteIndex == -1) {
                  context.showErrorSnackbar(
                    title: "Validation Error",
                    message: "Select a path",
                  );
                  return;
                }

                widget.onContinue(
                  widget.routes[selectedRouteIndex].polylineEncoded,
                );
              },
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

class _RouteTile extends StatelessWidget {
  final bool isSelected;
  final double distanceKm;
  final int durationMin;

  const _RouteTile({
    required this.isSelected,
    required this.distanceKm,
    required this.durationMin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? Colors.yellow.shade50 : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText("Available Route", size: 12),

          SizedBox(height: 4.h),

          Row(
            children: [
              CommonText(
                "${distanceKm.toStringAsFixed(1)} Km  ",
                size: 14,
                isBold: true,
              ),
              CommonText(
                "($durationMin min)",
                size: 12,
                isBold: true,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
