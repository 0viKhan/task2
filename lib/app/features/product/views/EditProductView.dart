import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  String? selectedCategory;
  String? selectedBrand;

  final categories = [
    "Electronics",
    "Furniture",
    "Fashion",
    "Appliances",
  ];

  final brands = [
    "Apple",
    "Samsung",
    "Sony",
    "LG",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            /// 🔹 Top Bar
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
                        "Edit Product",
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

                    /// 🔹 Upload Photo Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.image_outlined, size: 50),
                          const SizedBox(height: 12),
                          const Text(
                            "Upload photo",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Upload the front side of your document\nSupports: JPG, PNG, PDF",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text("Choose a file"),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Product Name
                    const Text("Product Name"),
                    const SizedBox(height: 8),
                    _inputField(
                      controller: _nameController,
                      hint: "Type product name",
                    ),

                    const SizedBox(height: 20),

                    /// Category
                    const Text("Select Category"),
                    const SizedBox(height: 8),
                    _dropdownField(
                      value: selectedCategory,
                      hint: "Select Categories",
                      items: categories,
                      onChanged: (val) {
                        setState(() => selectedCategory = val);
                      },
                    ),

                    const SizedBox(height: 20),

                    /// Description
                    const Text("Description"),
                    const SizedBox(height: 8),
                    _inputField(
                      controller: _descController,
                      hint: "Type Description",
                      maxLines: 4,
                    ),

                    const SizedBox(height: 20),

                    /// Price
                    const Text("Price"),
                    const SizedBox(height: 8),
                    _inputField(
                      controller: _priceController,
                      hint: "Type Price",
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 20),

                    /// Brand
                    const Text("Brand"),
                    const SizedBox(height: 8),
                    _dropdownField(
                      value: selectedBrand,
                      hint: "Select Brand",
                      items: brands,
                      onChanged: (val) {
                        setState(() => selectedBrand = val);
                      },
                    ),

                    const SizedBox(height: 30),

                    /// Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F6FED),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () {
                          Get.snackbar(
                            "Updated",
                            "Product updated successfully",
                          );
                        },
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Input Field
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
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

  /// 🔹 Reusable Dropdown
  Widget _dropdownField({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
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
}