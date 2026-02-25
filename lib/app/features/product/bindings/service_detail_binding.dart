import 'package:get/get.dart';

import '../../../../services/product_service.dart';
import '../controllers/product_controller.dart';

class ServiceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<ProductController>(() => ProductController());
  }
}