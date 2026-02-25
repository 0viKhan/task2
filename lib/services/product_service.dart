import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../app/core/constants/api_constants.dart';
import '../app/core/network/dio_client.dart';
import '../app/features/product/model/product_model.dart';

class ProductService {
  final Dio _dio = DioClient().dio;

  /// ✅ Get All Products
  Future<Response> getProducts() async {
    return await _dio.get(ApiConstants.products);
  }

  /// ✅ Create Product (Correct Version)
  Future<Response> createProduct({
    required ProductModel product,
    File? imageFile,
  }) async {

    final formData = FormData.fromMap({
      /// 🔥 IMPORTANT: Send JSON as string inside "data"
      "data": jsonEncode(product.toJson()),

      if (imageFile != null)
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    return await _dio.post(
      ApiConstants.products,
      data: formData,
    );
  }
}