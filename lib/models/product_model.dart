import 'package:flutter/foundation.dart';
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
    String rawImage = (json['fullImage'] ?? json['imgUrl'] ?? '')
        .toString()
        .trim();
    if (rawImage.isNotEmpty) {
      // 1. Strip duplicated base URLs
      if (rawImage.contains('http://localhost:8080http://localhost:8080')) {
        rawImage = rawImage.replaceAll(
          'http://localhost:8080http://localhost:8080',
          'http://localhost:8080',
        );
      }
      // 2. Fix missing slashes before static
      if (rawImage.contains('8080static/')) {
        rawImage = rawImage.replaceAll('8080static/', '8080/static/');
      }
      // 3. Android Emulator host routing
      if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
        rawImage = rawImage.replaceAll('localhost', '10.0.2.2');
        rawImage = rawImage.replaceAll('127.0.0.1', '10.0.2.2');
      }
      // 4. Safely encode spaces and brackets in filenames
      rawImage = Uri.encodeFull(rawImage);
    }
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: double.parse((json['price'] ?? 0.0).toString()),
      qty: int.tryParse((json['qty'] ?? 0).toString()) ?? 0,
      imageUrl: rawImage.isNotEmpty ? rawImage : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'qty': qty};
  }
}
