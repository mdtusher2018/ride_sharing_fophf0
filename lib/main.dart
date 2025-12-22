import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/home/take_image_view.dart';
import 'package:velozaje/feature/splash_onboarding/splash_screen.dart';
import 'package:get/get.dart';
import 'package:velozaje/localization/app_translate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TakePhotoPage.cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => GetMaterialApp(
        title: 'Velozaje',

        translations: AppTranslations(),
        locale: const Locale('en', 'ES'),
        fallbackLocale: const Locale('en', 'ES'),

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
