import 'package:flutter/rendering.dart';

class ProductModel {
  final int id;
  final String name;
  final double price;
  final int qty;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    this.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // 1. Clean & normalize the image URL coming from Spring Boot
    String rawImage = (json['fullImage'] ?? json['imgUrl'] ?? '')
        .toString()
        .trim();

    if (rawImage.isNotEmpty) {
      // Fix duplicate base URLs if present from backend
      if (rawImage.contains('http://localhost:8080http://localhost:8080')) {
        rawImage = rawImage.replaceAll(
          'http://localhost:8080http://localhost:8080',
          'http://localhost:8080',
        );
      }
      // Fix missing slashes before static
      if (rawImage.contains('8080static/')) {
        rawImage = rawImage.replaceAll('8080static/', '8080/static/');
      }
      // If testing on Android Emulator, change localhost to 10.0.2.2
      // rawImage = rawImage.replaceAll('localhost', '10.0.2.2');
    }
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: double.parse((json['price'] ?? 0.0).toString()),
      qty: int.tryParse((json['qty'] ?? 0).toString()) ?? 0,
      imageUrl: json['image_url'] ?? json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'qty': qty};
  }
}
