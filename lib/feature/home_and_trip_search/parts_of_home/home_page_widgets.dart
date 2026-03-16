part of '../home_view.dart';

List<PackageControllers> packageControllers = [];

int count = 1;

void _initializedController(int count) {
  packageControllers.clear();

  for (int i = 0; i < count; i++) {
    packageControllers.add(PackageControllers());
  }
}

/// 🔘 Tab Button
Widget tabButton(String text, bool selected, VoidCallback onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: CommonText(
          text,
          size: 14,
          fontWeight: FontWeight.w600,
          color: selected ? AppColors.primary : Colors.grey,
        ),
      ),
    ),
  );
}

/// ℹ️ Info Box
Widget infoBox(IconData icon, String text) {
  return Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: AppColors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.grey),
        SizedBox(width: 8.w),
        Expanded(child: CommonText(text, size: 13.sp)),
      ],
    ),
  );
}

Widget topBar(BuildContext context, WidgetRef ref) {
  final state = ref.watch(profileControllerProvider);
  return Positioned(
    left: 0,
    right: 0,
    child: Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 48.h,
        bottom: 30.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16.r),
          bottomRight: Radius.circular(16.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              border: Border.all(color: AppColors.primary, width: 1),
            ),
            child: ClipOval(
              child: CommonImage(
                path: state.user?.image ?? "",
                width: 80.w,
                sourceType: ImageSourceType.network,
                height: 80.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                AppLocalizations.of(context)!.where_to,
                size: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              CommonText(
                AppLocalizations.of(context)!.find_a_ride_or_send_a_package,
                size: 12,
                color: Colors.white70,
              ),
            ],
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotificationView();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badge(
                isLabelVisible:
                    ref
                        .watch(notificationsControllerProvider.notifier)
                        .unreadCount >
                    0,
                label: Text(
                  ref
                      .watch(notificationsControllerProvider.notifier)
                      .unreadCount
                      .toString(),
                ),
                smallSize: 10,
                child: Icon(
                  Icons.notifications_rounded,
                  color: AppColors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget savedPlaceButtonCard(BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SavedPlacePage();
          },
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.all(14.w),
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.star),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  AppLocalizations.of(context)!.saved_places,
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget weightCard(int index, BuildContext context) {
  return SizedBox(
    height: 75,
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(AppLocalizations.of(context)!.weight_kg, size: 10),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: packageControllers[index].weight,
                  decoration: InputDecoration(
                    hintText: "0",
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: packageControllers[index].length,
                      decoration: InputDecoration(
                        hintText: "L(cm)",
                        hintStyle: TextStyle(fontSize: 12),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              CommonText(" x "),
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: packageControllers[index].width,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "W(cm)",
                        hintStyle: TextStyle(fontSize: 12),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              CommonText(" x "),
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: packageControllers[index].height,
                      decoration: InputDecoration(
                        hintText: "H(cm)",
                        hintStyle: TextStyle(fontSize: 12),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _counterBoxForPerson({
  required Function() onIncrease,
  required Function() onDecrease,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: [
        Icon(Icons.person_2_outlined),
        SizedBox(width: 16.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (count > 1) onDecrease();
                },
                child: Container(
                  padding: EdgeInsets.all(4),

                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.remove),
                ),
              ),
              CommonText(count.toString(), size: 14.sp),
              InkWell(
                onTap: () {
                  onIncrease();
                },
                child: Container(
                  padding: EdgeInsets.all(4),

                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _counterBoxForPackage({
  required Function() onIncrease,
  required Function() onDecrease,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: AppColors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: [
        Icon(Iconsax.box_1_outline),
        SizedBox(width: 16.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (count > 0) {
                    onDecrease();
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(4),

                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.remove),
                ),
              ),
              CommonText(count.toString(), size: 14.sp),
              InkWell(
                onTap: () {
                  onIncrease();

                  _initializedController(count);
                },
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
