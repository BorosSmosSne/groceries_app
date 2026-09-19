import 'package:flutter/material.dart';
import 'package:groceries_app/models/product.dart';
import 'package:groceries_app/screens/product_detail.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle card tap if needed
        Navigator.push(
          context,
          // MaterialPageRoute(
          //   builder: (context) => ProductDetailScreen(product: product),
          // ),
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetailScreen(product: product),
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // 1. Slide: Starts slightly below (20%) and rises to default position
              final slideAnimation =
                  Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    ),
                  );

              // 2. Fade: Transitions opacity from 0.0 to 1.0
              final fadeAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              );

              return SlideTransition(
                position: slideAnimation,
                child: FadeTransition(opacity: fadeAnimation, child: child),
              );
            },
          ),
        );
      },
      child: Container(
        width: 174,
        height: 249,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                child: Hero(
                  tag: product.id.toString(),
                  child: Image.asset(product.image, width: 100),
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.name,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 6),
            Text(
              product.description,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
                fontFamily: 'Poppins',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.white),
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
      ),
    );
  }
}
