import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../core/storage/pref_service.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> slideAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
    );

    slideAnimation = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    animationController.forward();

    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final token = await PrefService.to.getToken();

    debugPrint("TOKEN FROM STORAGE: $token");

    if (token != null && token.isNotEmpty) {
      debugPrint("Splash: Token found → Dashboard");
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      debugPrint("Splash: No token → Onboarding");
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}