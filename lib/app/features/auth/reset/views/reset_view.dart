import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/auth_service.dart';
import '../../../../routes/app_routes.dart';

class ResetView extends StatefulWidget {
  const ResetView({super.key});

  @override
  State<ResetView> createState() => _ResetViewState();
}

class _ResetViewState extends State<ResetView> {
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final args = Get.arguments ?? {};
    final email = args["email"];
    final token = args["token"];

    if (email == null || token == null) {
      Get.snackbar("Error", "Invalid reset session");
      return;
    }

    try {
      final response = await Get.find<AuthService>().resetPassword(
        email: email,
        password: _newPassController.text.trim(),
        token: token,
      );

      print("RESET RESPONSE: ${response.data}");

      if (response.statusCode == 200 &&
          response.data["success"] == true) {

        Get.snackbar("Success", "Password changed successfully");

        Get.offAllNamed(AppRoutes.login);

      } else {
        Get.snackbar(
          "Error",
          response.data["message"] ?? "Reset failed",
        );
      }

    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Get.back(),
                ),

                const SizedBox(height: 28),

                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 28),

                const Text("New Password",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),

                const SizedBox(height: 8),

                _buildPasswordField(
                  controller: _newPassController,
                  obscure: _obscure1,
                  toggle: () =>
                      setState(() => _obscure1 = !_obscure1),
                ),

                const SizedBox(height: 18),

                const Text("Confirm Password",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),

                const SizedBox(height: 8),

                _buildPasswordField(
                  controller: _confirmPassController,
                  obscure: _obscure2,
                  toggle: () =>
                      setState(() => _obscure2 = !_obscure2),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text("Submit"),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Field is required";
        }
        if (value.length < 8) {
          return "Minimum 8 characters required";
        }
        if (controller == _confirmPassController &&
            value != _newPassController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
    );
  }
}