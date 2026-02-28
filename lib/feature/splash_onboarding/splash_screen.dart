import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/core/services/localstorage/storage_key.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/feature/root_view.dart';
import 'dart:async';
import 'package:velozaje/feature/splash_onboarding/onboarding_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToPage();
  }

  void navigateToPage() async {
    Future.delayed(Duration(seconds: 3), () async {
      final localStorage = ref.read(localStorageProvider);
      final token = await localStorage.getString(StorageKey.accessToken);
      log(token.toString());

      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => RootPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnboardingPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbg,
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(seconds: 2),
          child: Image.asset('assest/image/logo.png'),
        ),
      ),
    );
  }
}
