import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velozaje/feature/home/take_image_view.dart';
import 'package:velozaje/feature/root_view.dart';
import 'package:velozaje/feature/splash_onboarding/splash_screen.dart';
import 'package:velozaje/feature/tips_and_publications/published/process/publish_process_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TakePhotoPage.cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        child: SplashScreen(),
      ),
    );
  }
}
