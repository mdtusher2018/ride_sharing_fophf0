// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/feature/tips_and_publications/published/published_trips_view.dart';
import 'package:velozaje/feature/tips_and_publications/passenger_booked_tips_view.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/app_colors.dart';

enum _TipsTab { booked, published }

class TipsAndPublicationPage extends StatefulWidget {
  const TipsAndPublicationPage({super.key});

  @override
  State<TipsAndPublicationPage> createState() => _TipsAndPublicationPageState();
}

class _TipsAndPublicationPageState extends State<TipsAndPublicationPage> {
  _TipsTab selectedTab = _TipsTab.published;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: SizedBox(),
        centerTitle: true,
        title: CommonText(
          AppLocalizations.of(context)!.my_tips,
          size: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            _SegmentedControl(
              selectedTab: selectedTab,
              onChanged: (tab) {
                setState(() => selectedTab = tab);
              },
            ),

            SizedBox(height: 16.h),

            /// TAB CONTENT
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: selectedTab == _TipsTab.booked
                    ? BookedTipsPage()
                    : PublishedTripsPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  final _TipsTab selectedTab;
  final ValueChanged<_TipsTab> onChanged;

  const _SegmentedControl({required this.selectedTab, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          _TabItem(
            title: AppLocalizations.of(context)!.booked,
            isSelected: selectedTab == _TipsTab.booked,
            onTap: () => onChanged(_TipsTab.booked),
          ),
          _TabItem(
            title: AppLocalizations.of(context)!.published,
            isSelected: selectedTab == _TipsTab.published,
            onTap: () => onChanged(_TipsTab.published),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: CommonText(
              title,
              size: 14,
              color: isSelected ? AppColors.primary : Colors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
