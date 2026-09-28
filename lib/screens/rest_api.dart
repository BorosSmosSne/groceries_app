import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/product_model.dart';

class RestApi {
  static String get baseUrl {
    if (kIsWeb) return 'http://127.0.0.1:8080/api/product';
    return 'http://10.0.2.2:8080/api/product';
  }

  // 1. READ ALL
  static Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else if (response.statusCode == 404) {
      return [];
    }
    throw Exception('Failed to load products: ${response.statusCode}');
  }

  // 2. READ BY ID
  static Future<ProductModel> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load product details');
  }

  // 3. CREATE (POST with Multipart imageFile)
  static Future<bool> createProduct({
    required String name,
    required double price,
    required int qty,
    XFile? imageFile,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(baseUrl));
      request.fields['name'] = name;
      request.fields['price'] = price.toString();
      request.fields['qty'] = qty.toString();

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imageFile', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      return streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201;
    } catch (e) {
      debugPrint('Error creating product: $e');
      return false;
    }
  }

  // 4. UPDATE (PUT with Multipart imageFile)
  static Future<bool> updateProduct({
    required int id,
    required String name,
    required double price,
    required int qty,
    XFile? imageFile,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/$id'));
      request.fields['name'] = name;
      request.fields['price'] = price.toString();
      request.fields['qty'] = qty.toString();

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imageFile', imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      debugPrint(
        'Update Status: ${response.statusCode}, Body: ${response.body}',
      );

      return streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 202;
    } catch (e) {
      debugPrint('Error updating product: $e');
      return false;
    }
  }

  // 5. DELETE
  static Future<bool> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200 || response.statusCode == 202;
  }
}
