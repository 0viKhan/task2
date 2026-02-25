import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// Pages
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  _OnboardPage1(),
                  _OnboardPage2(), // ✅ next চাপলে এটা আসবে
                ],
              ),
            ),

            /// Dots
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(controller.totalPages, (i) {
                  final isActive = controller.currentIndex.value == i;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 18 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFF2F6FED) : const Color(0xFFD9E2FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              );
            }),

            const SizedBox(height: 22),

            /// Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F6FED),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 0,
                    ),
                    onPressed: controller.onNext,
                    child: Text(
                      controller.buttonText,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

/// ✅ Page-1 (আগেরটা)
class _OnboardPage1 extends StatelessWidget {
  const _OnboardPage1();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 10),

          /// illustration placeholder
          Expanded(
            child: Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFEAF2FF),
                ),
                child: const Center(
                  child: Icon(Icons.phone_iphone, size: 90, color: Colors.black54),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Best online courses\nin the world",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
          ),

          const SizedBox(height: 12),

          const Text(
            "Now you can learn anywhere, anytime, even if there is no internet access!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF6B7280)),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

/// ✅ Page-2 (তোমার screenshot মতো)
class _OnboardPage2 extends StatelessWidget {
  const _OnboardPage2();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 10),

          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 270,
                    height: 270,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEAF2FF),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 30,
                          offset: Offset(0, 18),
                          color: Color(0x22000000),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.notifications_none_rounded, size: 72, color: Color(0xFF111827)),
                    ),
                  ),

                  /// small dots around (simple)
                  const Positioned(top: 25, left: 35, child: _Dot(color: Color(0xFF2F6FED))),
                  const Positioned(top: 60, right: 20, child: _Dot(color: Color(0xFFF59E0B))),
                  const Positioned(left: 10, top: 145, child: _Dot(color: Color(0xFF22C55E))),
                  const Positioned(bottom: 70, left: 90, child: _Dot(color: Color(0xFF2F6FED))),
                  const Positioned(bottom: 80, right: 60, child: _Dot(color: Color(0xFF2F6FED))),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Explore your new skill\ntoday",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
          ),

          const SizedBox(height: 12),

          const Text(
            "Our platform is designed to help you explore new skills. Let’s learn & grow with Eduline!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF6B7280)),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}