class Product {
  int id;
  String name;
  String description;
  double price;
  String image;
  String description2;
  String nutrition;
  List<String>? images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.description2,
    required this.nutrition,
    this.images,
  });
}
