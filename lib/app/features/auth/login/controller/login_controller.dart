import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../../../services/auth_service.dart';
import '../../../../core/storage/pref_service.dart';
import '../../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final isLoading = false.obs;
  final isObscure = true.obs;

  void togglePassword() {
    isObscure.value = !isObscure.value;
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final dio.Response response = await _authService.login(
        email: email,
        password: password,
      );

      print("LOGIN RESPONSE: ${response.data}");

      if (response.statusCode == 200 &&
          response.data?["success"] == true) {

        /// ✅ Backend returns: data.token
        final token = response.data["data"]?["token"];

        if (token == null || token.toString().isEmpty) {
          Get.snackbar("Error", "Token not found in response");
          return;
        }

        /// ✅ Save token
        /// ✅ Save token
        await PrefService.setString("token", token.toString());

        print("TOKEN SAVED: $token");

        /// Go to dashboard
        Get.offAllNamed(AppRoutes.dashboard);

      } else {
        final message =
            response.data?["message"] ?? "Login failed";

        Get.snackbar("Error", message);
      }
    } on dio.DioException catch (e) {
      String errorMessage = "Login failed";

      if (e.response?.data is Map) {
        errorMessage =
            e.response?.data["message"] ?? errorMessage;
      } else if (e.response?.data is String) {
        errorMessage = e.response?.data;
      }

      Get.snackbar("Error", errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}