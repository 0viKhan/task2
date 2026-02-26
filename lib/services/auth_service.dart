import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../app/core/constants/api_constants.dart';
import '../app/core/network/dio_client.dart';
import '../app/core/storage/pref_service.dart';

class AuthService extends GetxService {
  final dio.Dio _dio = DioClient().dio;

  /// =========================
  /// Register
  /// =========================
  Future<dio.Response> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return await _dio.post(
      ApiConstants.register,
      data: {
        "fullName": fullName,
        "email": email,
        "password": password,
      },
    );
  }

  /// =========================
  /// Login
  /// =========================
  Future<dio.Response> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    final token = response.data["token"];
    if (token != null) {
      await PrefService.setString("token", token);
    }

    return response;
  }

  /// =========================
  /// Logout
  /// =========================
  Future<void> logout() async {
    await PrefService.remove("token");
  }

  /// =========================
  /// Forgot Password (Send OTP)
  /// =========================
  Future<dio.Response> forgotPassword({
    required String email,
  }) async {
    return await _dio.post(
      ApiConstants.forgotPassword,
      data: {"email": email},
    );
  }

  /// =========================
  /// Verify OTP
  Future<dio.Response> verifyOtp({
    required String email,
    required int otp,   // int রাখো
  }) async {
    return await _dio.post(
      ApiConstants.verifyOtp,
      data: {
        "email": email,
        "otp": otp,
      },
    );
  }
  /// =========================
  /// Reset Password
  /// =========================
  Future<dio.Response> resetPassword({
    required String email,
    required String password,
    required String token,
  }) async {
    return await _dio.post(
      ApiConstants.resetPassword,
      options: dio.Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}