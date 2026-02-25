import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class OnboardingController extends GetxController {
  late final PageController pageController;

  final RxInt currentIndex = 0.obs;
  final int totalPages = 2; // ✅ must match PageView children count

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  String get buttonText =>
      currentIndex.value == totalPages - 1 ? "Get Started" : "Next";

  void onNext() {
    debugPrint("ONBOARD index=${currentIndex.value} total=$totalPages");

    if (currentIndex.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    } else {
      debugPrint("GO LOGIN -> ${AppRoutes.login}");
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}