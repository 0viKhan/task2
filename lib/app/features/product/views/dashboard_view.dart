import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../routes/app_routes.dart';

import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';


import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../routes/app_routes.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';

class DashboardView extends GetView<ProductController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SafeArea(
        child: Column(
          children: [

            /// 🔵 HEADER
            Container(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2F6FED),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.profile);
                    },
                    child: CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.person_outline, // better profile icon
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    "My Products",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// BODY
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "All Products",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// GRID
                    Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (controller.products.isEmpty) {
                          return const Center(
                              child: Text("No products found"));
                        }

                        return GridView.builder(
                          itemCount: controller.products.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 0.72,
                          ),
                          itemBuilder: (context, index) {
                            final ProductModel product =
                            controller.products[index];

                            return ProductCard(product: product);
                          },
                        );
                      }),
                    ),

                    /// CREATE BUTTON
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2F6FED),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(30.r),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.addProduct);
                          },
                          child: Text(
                            "Create Product",
                            style: TextStyle(
                                fontSize: 16.sp,
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
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(18.r)),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
          ),

          /// DETAILS (🔥 FIXED AREA)
          Expanded(   // ⭐ IMPORTANT FIX
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// NAME
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  /// STOCK
                  Text(
                    product.stock > 0
                        ? "✓ In Stock"
                        : "Out of Stock",
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: product.stock > 0
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),

                  const Spacer(), // ⭐ pushes buttons to bottom safely

                  /// BUTTONS
                  Row(
                    children: [

                      /// VIEW
                      Expanded(
                        child: InkWell(
                          borderRadius:
                          BorderRadius.circular(10.r),
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.serviceDetail,
                              arguments: product,
                            );
                          },
                          child: Container(
                            padding:
                            EdgeInsets.symmetric(vertical: 6.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F0FF),
                              borderRadius:
                              BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                "View",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color:
                                  const Color(0xFF2F6FED),
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 6.w),

                      /// EDIT
                      InkWell(
                        borderRadius:
                        BorderRadius.circular(16.r),
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.editProduct,
                            arguments: product,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(16.r),
                            border: Border.all(
                                color: Colors.grey.shade300),
                          ),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}