import 'package:dio/dio.dart';
import '../app/core/constants/api_constants.dart';
import '../app/core/network/dio_client.dart';

class AuthService {
  final Dio _dio = DioClient().dio;

  Future<Response> register({
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
        // 🔥 fcmToken remove
      },
    );
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    return await _dio.post(
      ApiConstants.login, // এটা add করতে হবে constants এ
      data: {
        "email": email,
        "password": password,
      },
    );
  }
}