class Product {
  final String id;
  final String category;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final List<String> relatedProducts;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.relatedProducts,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      category: json['category'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['image_url'],
      relatedProducts: List<String>.from(json['related_products']),
    );
  }
}
