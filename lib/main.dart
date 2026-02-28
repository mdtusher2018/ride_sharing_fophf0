import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/services/localstorage/local_storage_service.dart';
import 'package:velozaje/core/utils/constants.dart';
import 'package:velozaje/feature/splash_onboarding/splash_screen.dart';
import 'package:velozaje/feature/take_image_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TakePhotoPage.cameras = await availableCameras();
  await LocalStorageService.init();

  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.updateLocale(locale); // Call the updateLocale method
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', 'US');
  void updateLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
        title: 'Velozaje',
        navigatorKey: navigatorKey,

        locale: _locale,

        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
