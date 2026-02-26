import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../app/core/constants/api_constants.dart';
import '../app/core/network/dio_client.dart';
import '../app/features/product/model/product_model.dart';

class ProductService {
  final Dio _dio = DioClient().dio;

  /// ===============================
  /// ✅ Get All Products
  /// ===============================
  Future<Response> getProducts() async {
    return await _dio.get(
      ApiConstants.products,
    );
  }

  /// ===============================
  /// ✅ Create Product
  /// ===============================
  Future<Response> createProduct({
    required ProductModel product,
    File? imageFile,
  }) async {

    final formData = FormData.fromMap({
      /// 🔥 Backend expects JSON string inside "data"
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

  /// ===============================
  /// ✅ Update Product (PUT)
  /// ===============================
  Future<Response> updateProduct({
    required String id,
    required ProductModel product,
    File? imageFile,
  }) async {

    final formData = FormData.fromMap({
      /// 🔥 Same structure as create
      "data": jsonEncode(product.toJson()),

      if (imageFile != null)
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    return await _dio.put(
      "${ApiConstants.products}/$id",
      data: formData,
    );
  }

  /// ===============================
  /// ✅ Delete Product
  /// ===============================
  Future<Response> deleteProduct(String id) async {
    return await _dio.delete(
      "${ApiConstants.products}/$id",
    );
  }
}