import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../routes/app_routes.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Column(
          children: [

            /// 🔵 BLUE HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              decoration: const BoxDecoration(
                color: Color(0xFF2F6FED),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=3"),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi, Wade Warren!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "📍 Golder Avenue, Abuja",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// WHITE BODY CONTAINER
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 10),

                    const Text(
                      "My Services",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// Tabs
                    Row(
                      children: [
                        _TabButton(title: "Ongoing", active: true),
                        const SizedBox(width: 12),
                        _TabButton(title: "Upcoming"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Grid
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        if (controller.products.isEmpty) {
                          return const Center(child: Text("No products found"));
                        }

                        return GridView.builder(
                          itemCount: controller.products.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, index) {
                            final product = controller.products[index];

                            return ProductCard(
                              title: product.name,
                              price: "\$${product.price}",
                              image: product.image ??
                                  "https://via.placeholder.com/300",
                            );
                          },
                        );
                      }),
                    ),

                    /// Create Product Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF2F6FED),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.addProduct);
                          },
                          child: const Text(
                            "Create Product",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String title;
  final bool active;

  const _TabButton({
    required this.title,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF2F6FED)
            : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          /// Image
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(
                    top: Radius.circular(18)),
                child: Image.network(
                  image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "ELECTRONICS",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight:
                        FontWeight.w600),
                  ),
                ),
              ),

              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4),
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFF2F6FED),
                    borderRadius:
                    BorderRadius.circular(
                        12),
                  ),
                  child: Text(
                    price,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding:
            const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight:
                      FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  "✓ In Stock",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 12),
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.serviceDetail,
                            arguments: {
                              "title": title,
                              "price": price,
                              "image": image,
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F0FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "View Details",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF2F6FED),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Get.toNamed(AppRoutes.editProduct);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}