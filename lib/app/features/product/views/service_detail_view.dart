import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceDetailView extends StatelessWidget {
  const ServiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
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
                        "Service Detail",
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

                      /// Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              "https://images.unsplash.com/photo-1518441902117-9a3c6b3f07b4",
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),

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
                                child: const Text(
                                  "ELECTRONICS",
                                  style: TextStyle(
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

                      /// Title + Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Headphone",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "\$22.50",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: const [
                          Text(
                            "✓ In Stock",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Discount: \$10",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(),

                      const SizedBox(height: 14),

                      /// Subtitle
                      const Text(
                        "Corsair Gaming Headphones",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      /// Feature Chips
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: const [
                          _Chip(text: "Peripherals Catagorie"),
                          _Chip(text: "Gaming"),
                          _Chip(text: "Corsair Brand"),
                          _Chip(text: "Weight: 0.9"),
                          _Chip(text: "Dimensions: 45 x 13 x 2.5 cm"),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "PipeMaster Plumbing is not just a service; it's a commitment to providing reliable and efficient plumbing solutions...",
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// Edit Button
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
                          onPressed: () {},
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
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 8),
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