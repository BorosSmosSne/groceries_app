import 'package:flutter/material.dart';
import 'package:groceries_app/helpers/product_card.dart';
import 'package:groceries_app/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Organic Banana',
      description: '7pcs, Price',
      price: 4.9999,
      image: 'assets/images/bananas.jpg',
    ),
    Product(
      id: 1,
      name: 'Organic Banana',
      description: '7pcs, Price',
      price: 4.9999,
      image: 'assets/images/bananas.jpg',
    ),
    Product(
      id: 1,
      name: 'Organic Banana',
      description: '7pcs, Price',
      price: 4.9999,
      image: 'assets/images/bananas.jpg',
    ),
    Product(
      id: 1,
      name: 'Organic Banana',
      description: '7pcs, Price',
      price: 4.9999,
      image: 'assets/images/bananas.jpg',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            Row(
              children: _products
                  .map((product) => ProductCard(product: product))
                  .toList(),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton.extended(onPressed: () {}),
    );
  }
}
