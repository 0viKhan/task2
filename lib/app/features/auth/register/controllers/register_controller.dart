import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../services/auth_service.dart';
import '../../../../core/constants/api_constants.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  var isLoading = false.obs;

  Future<void> registerUser({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      /// 🔥 PRINT BASE URL
      print("BASE URL: ${ApiConstants.baseUrl}");
      print("ENDPOINT: users/register");
      print("REQUEST BODY: {");
      print("  fullName: $fullName");
      print("  email: $email");
      print("  password: $password");
      print("}");

      final dio.Response response =
      await _authService.register(
        fullName: fullName,
        email: email,
        password: password,
      );

      /// 🔥 PRINT RESPONSE
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE DATA: ${response.data}");

      if (response.statusCode == 201 &&
          response.data["success"] == true) {
        Get.snackbar("Success", response.data["message"]);
        Get.toNamed('/verify');
      } else {
        Get.snackbar(
          "Error",
          response.data["message"] ?? "Registration failed",
        );
      }
    } on dio.DioException catch (e) {
      /// 🔥 PRINT ERROR DETAILS
      print("===== DIO ERROR =====");
      print("ERROR TYPE: ${e.type}");
      print("ERROR MESSAGE: ${e.message}");
      print("STATUS CODE: ${e.response?.statusCode}");
      print("ERROR DATA: ${e.response?.data}");
      print("=====================");

      Get.snackbar(
        "Error",
        e.response?.data?["message"] ?? "Registration failed",
      );
    } catch (e) {
      print("UNEXPECTED ERROR: $e");
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}