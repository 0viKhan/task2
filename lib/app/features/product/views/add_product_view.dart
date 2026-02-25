import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final controller = Get.find<ProductController>();
  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  final _discount = TextEditingController();
  final _weight = TextEditingController();

  String? category;
  String? brand;
  String? stock;
  String? tag;
  String? status;
  String? color;

  final categories = ["Electronics", "Furniture", "Fashion"];
  final brands = ["Apple", "Samsung", "Sony"];
  final stocks = ["In Stock", "Out of Stock"];
  final tags = ["Featured", "Popular", "New"];
  final statuses = ["Active", "Inactive"];
  final colors = ["Red", "Blue", "Black", "White"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            /// 🔹 Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Add New Product",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const Divider(height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// Upload Photo
                    _uploadBox(),

                    const SizedBox(height: 24),

                    _label("Product Name"),
                    _input(_name, "Type product name"),

                    const SizedBox(height: 20),

                    _label("Select Category"),
                    _dropdown(category, "Select Categories", categories,
                            (v) => setState(() => category = v)),

                    const SizedBox(height: 20),

                    _label("Description"),
                    _input(_desc, "Type Description", maxLines: 4),

                    const SizedBox(height: 20),

                    _label("Price"),
                    _input(_price, "Type Price",
                        keyboardType: TextInputType.number),

                    const SizedBox(height: 20),

                    _label("Brand"),
                    _dropdown(brand, "Select Brand", brands,
                            (v) => setState(() => brand = v)),

                    const SizedBox(height: 20),

                    _label("Discount"),
                    _input(_discount, "Type Discount",
                        keyboardType: TextInputType.number),

                    const SizedBox(height: 20),

                    _label("Stock"),
                    _dropdown(stock, "Select Stock", stocks,
                            (v) => setState(() => stock = v)),

                    const SizedBox(height: 20),

                    _label("Tags"),
                    _dropdown(tag, "Select Tag", tags,
                            (v) => setState(() => tag = v)),

                    const SizedBox(height: 20),

                    _label("Active"),
                    _dropdown(status, "Select Status", statuses,
                            (v) => setState(() => status = v)),

                    const SizedBox(height: 20),

                    _label("Weight"),
                    _input(_weight, "Type weight",
                        keyboardType: TextInputType.number),

                    const SizedBox(height: 20),

                    _label("Colors"),
                    _dropdown(color, "Select color", colors,
                            (v) => setState(() => color = v)),

                    const SizedBox(height: 30),

                    /// Save Button
                    Obx(() => SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.isCreating.value
                            ? null
                            : () {
                          controller.createProduct(
                            name: _name.text.trim(),
                            price:
                            double.tryParse(_price.text) ?? 0,
                            stock: stock == "In Stock"
                                ? 100
                                : 0,
                            description:
                            _desc.text.trim(),
                            category: category,
                            brand: brand,
                            discountPercent:
                            double.tryParse(
                                _discount.text),
                            isActive:
                            status == "Active",
                            weight:
                            double.tryParse(
                                _weight.text),
                            tags: tag != null
                                ? [tag!]
                                : null,
                            colors: color != null
                                ? [color!]
                                : null,
                          );
                        },
                        child: controller.isCreating.value
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text("Add Product"),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Widgets

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _input(TextEditingController controller, String hint,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xFFF3F4F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dropdown(String? value, String hint, List<String> items,
      Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(hint),
        isExpanded: true,
        underline: const SizedBox(),
        items: items
            .map((e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _uploadBox() {
    final controller = Get.find<ProductController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          const Icon(Icons.image_outlined, size: 50),
          const SizedBox(height: 12),

          const Text(
            "Upload photo",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Supports: JPG, PNG",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 16),

          /// 🔥 Image Pick Button
          OutlinedButton(
            onPressed: controller.pickImage,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Choose a file"),
          ),

          const SizedBox(height: 16),

          /// 🔥 Image Preview
          Obx(() {
            final image = controller.selectedImage.value;

            if (image == null) return const SizedBox();

            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    image,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: controller.clearImage,
                  child: const Text(
                    "Remove Image",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}