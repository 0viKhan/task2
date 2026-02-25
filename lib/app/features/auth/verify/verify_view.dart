import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';


class VerifyView extends StatefulWidget {
  const VerifyView({super.key});

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final List<String> code = ["", "", "", ""];

  void _onKeyTap(String value) {
    if (value.isEmpty) return;

    for (int i = 0; i < code.length; i++) {
      if (code[i].isEmpty) {
        setState(() {
          code[i] = value;
        });
        break;
      }
    }
  }

  void _onBackspace() {
    for (int i = code.length - 1; i >= 0; i--) {
      if (code[i].isNotEmpty) {
        setState(() {
          code[i] = "";
        });
        break;
      }
    }
  }

  void _goToLocation() {
    Get.offAllNamed(AppRoutes.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Back Button
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () => Get.back(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Verify Code",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Please enter the code we just sent to your email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
            ),

            const SizedBox(height: 30),

            /// OTP Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 60,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Text(
                    code[index].isEmpty ? "•" : code[index],
                    style: const TextStyle(fontSize: 22),
                  ),
                );
              }),
            ),

            const Spacer(),

            /// Continue Button (Direct Location)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6FED),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: _goToLocation, // 🔥 direct navigate
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Number Pad
            _NumberPad(
              onTap: _onKeyTap,
              onBack: _onBackspace,
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberPad extends StatelessWidget {
  final Function(String) onTap;
  final VoidCallback onBack;

  const _NumberPad({
    required this.onTap,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final numbers = [
      "1","2","3",
      "4","5","6",
      "7","8","9",
      "","0","⌫"
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: numbers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (_, i) {
          final value = numbers[i];

          return GestureDetector(
            onTap: () {
              if (value == "⌫") {
                onBack();
              } else if (value.isNotEmpty) {
                onTap(value);
              }
            },
            child: Center(
              child: Text(
                value,
                style: const TextStyle(fontSize: 22),
              ),
            ),
          );
        },
      ),
    );
  }
}