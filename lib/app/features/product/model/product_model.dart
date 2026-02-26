class ProductModel {
  final String? id;
  final String name;
  final double price;
  final int stock;

  final String? description;
  final String? category;
  final String? brand;
  final String? image;
  final bool? isDiscounted;
  final double? discountPercent;
  final bool? isActive;
  final double? weight;
  final List<String>? colors;
  final List<String>? tags;
  final String? dimensions;

  // 🔥 NEW
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.description,
    this.category,
    this.brand,
    this.image,
    this.isDiscounted,
    this.discountPercent,
    this.isActive,
    this.weight,
    this.colors,
    this.tags,
    this.dimensions,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? json['id'],
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] ?? 0,
      description: json['description'],
      category: json['category'],
      brand: json['brand'],
      image: json['image'],
      isDiscounted: json['isDiscounted'],
      discountPercent: json['discountPercent'] != null
          ? (json['discountPercent'] as num).toDouble()
          : null,
      isActive: json['isActive'],
      weight: json['weight'] != null
          ? (json['weight'] as num).toDouble()
          : null,
      colors: json['colors'] != null
          ? List<String>.from(json['colors'])
          : null,
      tags: json['tags'] != null
          ? List<String>.from(json['tags'])
          : null,
      dimensions: json['dimensions'],

      // 🔥 ADDED
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,

      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "stock": stock,
      if (description != null) "description": description,
      if (category != null) "category": category,
      if (brand != null) "brand": brand,
      if (image != null) "image": image,
      if (isDiscounted != null) "isDiscounted": isDiscounted,
      if (discountPercent != null) "discountPercent": discountPercent,
      if (isActive != null) "isActive": isActive,
      if (weight != null) "weight": weight,
      if (colors != null) "colors": colors,
      if (tags != null) "tags": tags,
      if (dimensions != null) "dimensions": dimensions,
    };
  }
}