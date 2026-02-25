import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../services/product_service.dart';
import '../model/product_model.dart';

class DashboardController extends GetxController {
  final ProductService _service = ProductService();

  var isLoading = false.obs;
  var products = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      final dio.Response response =
      await _service.getProducts();

      if (response.statusCode == 200 &&
          response.data["success"] == true) {

        final List data = response.data["data"];

        products.value =
            data.map((e) => ProductModel.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load products");
    } finally {
      isLoading.value = false;
    }
  }
}