import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../model/product_model.dart';

class EditProductView extends StatefulWidget {
  const EditProductView({super.key});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final ProductController controller = Get.find();

  late ProductModel product;

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
  void initState() {
    super.initState();

    product = Get.arguments as ProductModel;

    /// 🔥 Prefill Data
    _nameController.text = product.name;
    _descController.text = product.description ?? '';
    _priceController.text = product.price.toString();

    selectedCategory = product.category;
    selectedBrand = product.brand;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _updateProduct() {
    if (product.id == null) {
      Get.snackbar("Error", "Invalid product ID");
      return;
    }

    controller.updateProduct(
      id: product.id!,
      product: ProductModel(
        id: product.id,
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        price: double.tryParse(_priceController.text) ?? 0,
        category: selectedCategory,
        brand: selectedBrand,
        stock: product.stock,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text("Product Name"),
              const SizedBox(height: 8),
              _inputField(
                controller: _nameController,
                hint: "Type product name",
              ),

              const SizedBox(height: 20),

              const Text("Select Category"),
              const SizedBox(height: 8),
              _dropdownField(
                value: selectedCategory,
                hint: "Select Category",
                items: categories,
                onChanged: (val) {
                  setState(() => selectedCategory = val);
                },
              ),

              const SizedBox(height: 20),

              const Text("Description"),
              const SizedBox(height: 8),
              _inputField(
                controller: _descController,
                hint: "Type Description",
                maxLines: 4,
              ),

              const SizedBox(height: 20),

              const Text("Price"),
              const SizedBox(height: 8),
              _inputField(
                controller: _priceController,
                hint: "Type Price",
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 20),

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

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _updateProduct,
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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