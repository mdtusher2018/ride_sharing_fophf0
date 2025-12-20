import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/tips_and_publications/published/my_published_details_view.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/utills/app_colors.dart';

class MyPublishedTripsPage extends StatelessWidget {
  const MyPublishedTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        TripCard(status: 'Active Trip', statusColor: AppColors.primary),
        TripCard(status: 'scheduled', statusColor: AppColors.textSecondary),
      ],
    );
  }
}

class TripCard extends StatelessWidget {
  final String status;
  final Color statusColor;

  const TripCard({super.key, required this.status, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MyPublishedDetailsPage();
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 16.h),
        color: AppColors.white,
        shadowColor: Colors.black,
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CommonText(status, size: 12, color: statusColor),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16),
                      SizedBox(width: 6.w),
                      CommonText('Saturday 10/20/25, 8:40 AM', size: 12),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 14.h),

              /// From - To
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.radio_button_checked, size: 14),
                      SizedBox(height: 6),
                      Container(
                        width: 1,
                        height: 30,
                        color: AppColors.textPrimary,
                      ),
                      SizedBox(height: 6),
                      Icon(Icons.location_on, size: 18),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText('From', size: 11, color: Colors.grey),
                        CommonText(
                          'Morelia, Avenida P. Calle 12',
                          size: 13,
                          maxline: 1,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10.h),
                        CommonText('To', size: 11, color: Colors.grey),
                        CommonText(
                          'Morelia, Avenida P. Calle 12',
                          size: 13,
                          maxline: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  CommonText('3h 30m', size: 11, color: Colors.grey),
                ],
              ),

              SizedBox(height: 16.h),

              /// Bottom Stats
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _TripStat(value: '3/4', label: 'Seats'),
                    _Divider(),
                    _TripStat(
                      value: '\$840',
                      label: 'Seats',
                      valueColor: AppColors.primary,
                    ),
                    _Divider(),
                    _TripStat(
                      value: '2',
                      label: 'Requests',
                      valueColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TripStat extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;

  const _TripStat({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonText(
          value,
          size: 16,
          fontWeight: FontWeight.w600,
          color: valueColor ?? AppColors.textPrimary,
        ),
        CommonText(label, size: 11, color: AppColors.textSecondary),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 30.h, color: AppColors.textPrimary);
  }
}
