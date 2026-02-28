import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(staticContentControllerProvider.notifier).getContact();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.read(staticContentControllerProvider);
    final controller = ref.read(staticContentControllerProvider.notifier);
    return Scaffold(
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.contact,
      ),
      backgroundColor: AppColors.mainbg,
      body: ValueListenableBuilder(
        valueListenable: controller.isLoading,
        builder: (_, isLoading, _) {
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (!isLoading &&
              state.email.isEmpty &&
              state.facebook.isEmpty &&
              state.facebook.isEmpty &&
              state.phone.isEmpty) {
            return Center(child: CommonText("No Contact info found"));
          }
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                if (state.email.isNotEmpty)
                  _contactCard(
                    title: "Email Us",
                    iconPath: "assets/image/gmail.png",
                    contactLink: "mailto:${state.email}", // Email link
                  ),
                SizedBox(height: 12.h),
                if (state.facebook.isNotEmpty)
                  _contactCard(
                    title: "Facebook",
                    iconPath: "assets/image/facebook.png",
                    contactLink:
                        "https://facebook.com/${state.facebook}", // Facebook link
                  ),
                SizedBox(height: 12.h),
                if (state.instagram.isNotEmpty)
                  _contactCard(
                    title: "Instagram",
                    iconPath: "assets/image/instagram.png",
                    contactLink:
                        "https://instagram.com/${state.instagram}", // Instagram link
                  ),
                SizedBox(height: 12.h),
                if (state.phone.isNotEmpty)
                  _contactCard(
                    title: "+880 4545 8788",
                    iconPath: "assets/image/call.png",
                    contactLink: "tel:${state.phone}", // Phone link
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _contactCard({
    required String title,
    required String iconPath,
    required String contactLink,
  }) {
    return Card(
      elevation: 1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(4.r),
        onTap: () async {
          // Open the respective app or service
          if (await canLaunch(contactLink)) {
            await launch(contactLink);
          } else {
            // Handle the error if the link cannot be opened
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open the contact method.')),
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              CommonImage(
                path: iconPath,
                width: 24.w,
                height: 24.w,
                sourceType: ImageSourceType.asset,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CommonText(title, size: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
