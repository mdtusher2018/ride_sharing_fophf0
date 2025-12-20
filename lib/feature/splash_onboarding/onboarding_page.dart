import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/auth/signin_view.dart';
import 'package:velozaje/utills/app_colors.dart';
import 'package:velozaje/res/common_button.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class OnboardingModel {
  final String image;
  final String groundImage;
  final String title;
  final String subtitle;

  OnboardingModel({
    required this.image,
    required this.groundImage,
    required this.title,
    required this.subtitle,
  });
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    image: 'assest/image/onboarding1.png',
    groundImage: 'assest/image/1.png',
    title: 'Travel Smarter, Together',
    subtitle:
        'Find long-distance rides or send packages securely with verified drivers.',
  ),
  OnboardingModel(
    image: 'assest/image/onboarding2.png',
    groundImage: 'assest/image/2.png',
    title: 'Verified People. Real Trips.',
    subtitle:
        'Every driver and user is ID-verified to keep every journey safe and reliable.',
  ),
  OnboardingModel(
    image: 'assest/image/onboarding3.png',
    groundImage: 'assest/image/3.png',
    title: 'Verified People. Real Trips.',
    subtitle:
        'Every driver and user is ID-verified to keep every journey safe and reliable.',
  ),
];

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void _next() {
    if (currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SignInPage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (i) => setState(() => currentIndex = i),
            itemBuilder: (_, index) {
              return _OnboardingItem(data: onboardingData[index]);
            },
          ),

          /// Bottom Button
          Positioned(
            bottom: 60.h,

            child: CommonButton(
              'Next',
              boarder: Border.all(color: AppColors.white),
              width: 250,
              boarderRadious: 100,
              textalign: TextAlign.center,
              onTap: _next,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingItem extends StatelessWidget {
  final OnboardingModel data;

  const _OnboardingItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonImage(path: data.image, width: 260),

            CommonImage(path: data.groundImage),
          ],
        ),
        Positioned(
          bottom: 180,
          width: MediaQuery.sizeOf(context).width * 0.8,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CommonText(
                  data.title,
                  size: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 12.h),
              CommonText(
                data.subtitle,
                size: 14.sp,
                color: AppColors.white,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
