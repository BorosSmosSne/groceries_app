import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/models/product2.dart';
import 'package:http/http.dart' as http;

class RestApi extends StatefulWidget {
  const RestApi({super.key});

  @override
  State<RestApi> createState() => _RestApiState();
}

class _RestApiState extends State<RestApi> {
  List<Product2> products = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  void getAllProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      // Process the successful response
      final data = json.decode(response.body);
      for (var element in data) {
        products.add(Product2.fromJson(element));
      }
    } else {
      // Handle the error
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Text(
                "Request Error",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              SizedBox(height: 16),
              Icon(Icons.clear_rounded, size: 48, color: Colors.red),
              SizedBox(height: 16),
              Text("Something went wrong! Please try again."),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },

                child: Text("Ok"),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rest API')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.50,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.black.withValues(alpha: 0.25),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.network(
                          products[index].image,
                          height: 200,
                          width: 180,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Text(products[index].title)),
                            Text('\$${products[index].price}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
