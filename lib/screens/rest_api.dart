import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class RestApi {
  // Web uses 127.0.0.1, Android emulator uses 10.0.2.2
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://127.0.0.1:8080/api/product';
    }
    return 'http://10.0.2.2:8080/api/product';
  }

  // 1. READ ALL (GET)
  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return []; // Return empty list when no products found
    }
    throw Exception('Failed to load products: ${response.statusCode}');
  }

  // 2. READ BY ID (GET /api/product/{id})
  static Future<ProductModel> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load product details');
  }

  // 3. CREATE (POST multipart/form-data)
  static Future<bool> createProduct({
    required String name,
    required double price,
    required int qty,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['qty'] = qty.toString();

    final streamedResponse = await request.send();
    return streamedResponse.statusCode == 200 || streamedResponse.statusCode == 201;
  }

  // 4. DELETE (DELETE /api/product/{id})
  static Future<bool> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200 || response.statusCode == 202;
  }
}