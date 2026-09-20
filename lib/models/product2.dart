class Product2{
  int id;
  String title;
  String image;
  num price;
  String description;

  Product2({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
  });

  factory Product2.fromJson(Map<String, dynamic> json) {
    return Product2(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
    );
  }
}