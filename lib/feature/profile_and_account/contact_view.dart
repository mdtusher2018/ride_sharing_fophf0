import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          if (!isLoading && state.contactPlatfroms.isEmpty) {
            return Center(child: CommonText("No Contact info found"));
          }
          return RefreshIndicator(
            onRefresh: () async {
              controller.getContact();
            },

            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.contactPlatfroms.length,
              itemBuilder: (context, index) => _contactCard(
                title: state.contactPlatfroms[index].name,
                iconPath: state.contactPlatfroms[index].thumbnail,
                contactLink: state.contactPlatfroms[index].link,
              ),
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
          String finalLink = contactLink;

          if (_isPhoneNumber(contactLink)) {
            finalLink = 'tel:$contactLink';
          } else if (_isEmail(contactLink)) {
            finalLink = 'mailto:$contactLink';
          }

          if (await canLaunch(finalLink)) {
            await launch(finalLink);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open the contact method.')),
            );

            await Clipboard.setData(ClipboardData(text: finalLink));

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Link copied to clipboard!')),
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
                fit: BoxFit.cover,
                sourceType: ImageSourceType.network,
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

  bool _isPhoneNumber(String link) {
    return RegExp(r'^\+?[0-9]+$').hasMatch(link);
  }

  bool _isEmail(String link) {
    return RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    ).hasMatch(link);
  }
}
