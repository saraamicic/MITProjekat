class ProductModel {
  final String id;
  final String title;
  final double price;
  final String category;
  final String image; // Dodato
  final String description; // Dodato

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.image,
    required this.description,
  });
}