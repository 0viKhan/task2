import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../verify/verify_view.dart';

class ResetView extends StatefulWidget {
  const ResetView({super.key});

  @override
  State<ResetView> createState() => _ResetViewState();
}

class _ResetViewState extends State<ResetView> {
  final _newPassController =
  TextEditingController(text: "12345678");
  final _confirmPassController =
  TextEditingController(text: "12345678");

  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              /// Back button
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),

              const SizedBox(height: 28),

              const Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Your password must be at least 8 characters long and include a combination of letters, numbers",
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 28),

              /// New Password
              const Text(
                "New Password",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _PasswordField(
                controller: _newPassController,
                obscure: _obscure1,
                onToggle: () =>
                    setState(() => _obscure1 = !_obscure1),
              ),

              const SizedBox(height: 18),

              /// Confirm Password
              const Text(
                "Confirm New Password",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              _PasswordField(
                controller: _confirmPassController,
                obscure: _obscure2,
                onToggle: () =>
                    setState(() => _obscure2 = !_obscure2),
              ),

              const Spacer(),

              /// Submit button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F6FED),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final newPass = _newPassController.text.trim();
                    final confirmPass = _confirmPassController.text.trim();

                    // 🔹 Empty check
                    if (newPass.isEmpty || confirmPass.isEmpty) {
                      Get.snackbar(
                        "Error",
                        "All fields are required",
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.red,
                      );
                      return;
                    }

                    // 🔹 Length check
                    if (newPass.length < 8) {
                      Get.snackbar(
                        "Error",
                        "Password must be at least 8 characters",
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.red,
                      );
                      return;
                    }

                    // 🔹 Match check
                    if (newPass != confirmPass) {
                      Get.snackbar(
                        "Error",
                        "Passwords do not match",
                        backgroundColor: Colors.red.shade100,
                        colorText: Colors.red,
                      );
                      return;
                    }

                    // ✅ Everything OK → Go to OTP verify
                    Get.toNamed(AppRoutes.verify);
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 18, vertical: 16),
        suffixIcon: IconButton(
          icon: Icon(
            obscure
                ? Icons.visibility_off
                : Icons.visibility,
            color: const Color(0xFF9CA3AF),
          ),
          onPressed: onToggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:
          const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide:
          const BorderSide(color: Color(0xFF2F6FED)),
        ),
      ),
    );
  }
}