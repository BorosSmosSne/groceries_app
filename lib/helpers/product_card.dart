import 'package:flutter/material.dart';
import 'package:groceries_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Added const to EdgeInsets
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        // Changed to .start so the text aligns to the left (optional)
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16), // Added const
          // Ensure this path is in your pubspec.yaml!
          Image.asset(product.image, width: 100),
          Text(
            // Added const
            product.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 8),
          Text(
            product.description,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black54,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ), // Added const

              Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add, color: Colors.white), // Added const
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
