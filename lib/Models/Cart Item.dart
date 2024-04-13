class CartItem {

  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
  int quantity; // Define quantity property
  CartItem({
    required this.category,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    this.quantity = 1, // Set default quantity to 1
  });
}
