import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../model/product_model.dart';

class ServiceDetailView extends StatelessWidget {
  const ServiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductModel product = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Column(
          children: [

            /// 🔹 Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Product Detail",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🔹 Body Container
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// 🖼 Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              product.image ?? "https://via.placeholder.com/300",
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),

                            if (product.category != null)
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    product.category!.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// 🔥 Title + Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      /// Stock + Discount
                      Row(
                        children: [
                          Text(
                            product.stock > 0
                                ? "✓ In Stock"
                                : "Out of Stock",
                            style: TextStyle(
                              color: product.stock > 0
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          if (product.isDiscounted == true)
                            Text(
                              "Discount: ${product.discountPercent ?? 0}%",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 14),

                      /// 🏷 Brand / Subtitle
                      if (product.brand != null)
                        Text(
                          product.brand!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                      const SizedBox(height: 16),

                      /// 🧩 Feature Chips
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [

                          if (product.weight != null)
                            _Chip(text: "Weight: ${product.weight} kg"),

                          if (product.dimensions != null)
                            _Chip(text: "Size: ${product.dimensions}"),

                          if (product.colors != null)
                            ...product.colors!
                                .map((c) => _Chip(text: c))
                                .toList(),

                          if (product.tags != null)
                            ...product.tags!
                                .map((t) => _Chip(text: t))
                                .toList(),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// 📄 Description
                      if (product.description != null) ...[
                        const Text(
                          "Description",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],

                      const SizedBox(height: 30),

                      /// ✏ Edit Button
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xFF2F6FED),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(28),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(
                              AppRoutes.editProduct,
                              arguments: product,
                            );
                          },
                          child: const Text(
                            "Edit Product",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text;

  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E6FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF5B5FC7),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}