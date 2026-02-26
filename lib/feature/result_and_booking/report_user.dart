import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/core/utils/extention.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:velozaje/res/common_text_field.dart';

class ReportUserPage extends ConsumerStatefulWidget {
  const ReportUserPage({super.key, required this.driverId});
  final String driverId;

  @override
  ConsumerState<ReportUserPage> createState() => _ReportUserPageState();
}

class _ReportUserPageState extends ConsumerState<ReportUserPage> {
  final TextEditingController detailsController = TextEditingController();

  int selectedIndex = -1;
  String? selectedSubjectId;

  @override
  void initState() {
    super.initState();
    ref.read(reportControllerProvider.notifier).fetchReportSubjects();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(reportControllerProvider.notifier);
    final state = ref.watch(reportControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.report_user,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              /// Warning box
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDDDD),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: CommonText(
                  AppLocalizations.of(
                    context,
                  )!.please_select_a_reason_for_reporting_osbaldo_garcia_this_is_anonymous_and_helps_keep_our_community_safe,

                  size: 12.sp,
                  color: const Color(0xFF910F0F),
                ),
              ),

              SizedBox(height: 20.h),

              /// Reasons (dynamic)
              ValueListenableBuilder(
                valueListenable: controller.isLoading,
                builder: (_, isLoading, _) {
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!isLoading && state.data.isEmpty) {
                    return CommonText("Could not fetch any report reason");
                  }
                  final reasons = state.data;
                  return Column(
                    children: [
                      ...List.generate(reasons.length, (index) {
                        return _ReportOption(
                          title: reasons[index].title,
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedSubjectId = reasons[index].id;
                            });
                          },
                        );
                      }),
                    ],
                  );
                },
              ),
              SizedBox(height: 24.h),

              CommonText(
                AppLocalizations.of(context)!.additional_details,
                size: 14.sp,
                fontWeight: FontWeight.w600,
              ),

              SizedBox(height: 10.h),

              CommonTextField(
                controller: detailsController,
                hintText: AppLocalizations.of(
                  context,
                )!.please_describe_what_happened,
                minLine: 4,
                keyboardType: TextInputType.multiline,
                boarderColor: Colors.transparent,
              ),
              SizedBox(height: 10.h),

              /// Submit button
              CommonButton(
                AppLocalizations.of(context)!.submit_report,
                color: Colors.red.shade600,
                textColor: Colors.white,
                isLoading: state.isLoading,
                textalign: TextAlign.center,
                height: 50,
                onTap: (selectedSubjectId == null)
                    ? () {
                        context.showErrorSnackbar(
                          title: "Validation Error",
                          message: "Please select a report subject",
                        );
                      }
                    : () async {
                        await controller.submitAReport(
                          reportedUserId: widget.driverId,
                          reportSubjectId: selectedSubjectId!,
                          additionalDetails: detailsController.text.trim(),
                          onCompleate: () {
                            selectedIndex = -1;
                            selectedSubjectId = null;
                            setState(() {});
                          },
                        );
                        // _showReportSubmitDialog(context);
                      },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReportOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReportOption({
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF2F2) : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              title,
              size: 14.sp,
              color: isSelected ? Colors.red : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
