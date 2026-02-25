import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';

import '../model/product_model.dart';
import '../../../../services/product_service.dart';
import 'dashboard_controller.dart';

class ProductController extends GetxController {
  final ProductService _service = Get.find<ProductService>();

  final isLoading = false.obs;
  final isCreating = false.obs;
  final errorMessage = ''.obs;

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final Rx<File?> selectedImage = Rx<File?>(null);

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  // ================================
  // IMAGE
  // ================================
  Future<void> pickImage() async {
    final picked =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  // ================================
  // GET PRODUCTS
  // ================================
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final res = await _service.getProducts();

      if (res.statusCode == 200 && res.data["success"] == true) {
        final List list = res.data["data"];

        products.assignAll(
          list.map((e) => ProductModel.fromJson(e)).toList(),
        );
      }
    } catch (_) {
      Get.snackbar("Error", "Failed to load products");
    } finally {
      isLoading.value = false;
    }
  }

  // ================================
  // CREATE PRODUCT
  // ================================
  Future<void> createProduct({
    required String name,
    required double price,
    required int stock,
    String? description,
    String? category,
    String? brand,
    double? discountPercent,
    bool? isActive,
    double? weight,
    List<String>? colors,
    List<String>? tags,
  }) async {
    try {
      isCreating.value = true;

      final product = ProductModel(
        name: name,
        price: price,
        stock: stock,
        description: description,
        category: category,
        brand: brand,
        isDiscounted: (discountPercent ?? 0) > 0,
        discountPercent: discountPercent,
        isActive: isActive,
        weight: weight,
        colors: colors,
        tags: tags,
      );

      final res = await _service.createProduct(
        product: product,
        imageFile: selectedImage.value,
      );

      if (res.statusCode == 201 || res.data["success"] == true) {
        final newProduct =
        ProductModel.fromJson(res.data["data"]);

        products.insert(0, newProduct);

        clearImage();

        Get.back();

        Get.snackbar("Success", "Product created successfully");

        if (Get.isRegistered<DashboardController>()) {
          Get.find<DashboardController>().fetchProducts();
        }
      } else {
        Get.snackbar(
            "Error", res.data["message"] ?? "Create failed");
      }
    } on dio.DioException catch (e) {
      Get.snackbar(
          "Error",
          e.response?.data["message"] ?? "Create failed");
    } finally {
      isCreating.value = false;
    }
  }
}