// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/feature/tips_and_publications/published/my_tip_published_view.dart';
import 'package:velozaje/feature/tips_and_publications/my_tips_view.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/core/utils/app_colors.dart';

enum TipsTab { booked, published }

class TipsAndPublicationPage extends StatefulWidget {
  const TipsAndPublicationPage({super.key});

  @override
  State<TipsAndPublicationPage> createState() => _TipsAndPublicationPageState();
}

class _TipsAndPublicationPageState extends State<TipsAndPublicationPage> {
  TipsTab selectedTab = TipsTab.published;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
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
                child: selectedTab == TipsTab.booked
                    ? MyTipsPage()
                    : MyPublishedTripsPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  final TipsTab selectedTab;
  final ValueChanged<TipsTab> onChanged;

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
            isSelected: selectedTab == TipsTab.booked,
            onTap: () => onChanged(TipsTab.booked),
          ),
          _TabItem(
            title: AppLocalizations.of(context)!.published,
            isSelected: selectedTab == TipsTab.published,
            onTap: () => onChanged(TipsTab.published),
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
