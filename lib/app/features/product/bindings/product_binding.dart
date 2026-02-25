import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../../../services/product_service.dart';
import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductService>(
          () => ProductService(),
      fenix: true,
    );

    Get.lazyPut<ProductController>(
          () => ProductController(),
    );
  }
}