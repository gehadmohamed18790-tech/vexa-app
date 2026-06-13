class ProductModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? categoryName;
  final String? imageUrl;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.categoryName,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      description: json['description'],
      categoryName: json['category'] != null ? json['category']['name'] : null,
      imageUrl: (json['images'] != null && (json['images'] as List).isNotEmpty) 
          ? json['images'][0] 
          : null,
    );
  }
}