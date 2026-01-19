class ProductModel {
  final String id;
  final String title;
  final double price;
  final String category;
  final String image; 
  final String description;
  final bool isBestseller;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
    required this.isBestseller,
  });
}