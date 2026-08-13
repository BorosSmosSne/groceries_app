import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:groceries_app/models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;
  bool _isFavorite = false;
  bool _isDetailExpanded = false;

  static const _green = Color(0xFF4CAF50);

  // -- logic Methods --
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  double get _totalPrice => widget.product.price * _quantity;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar(),
            // Image.asset(product.image, width: 320, height: 200),
            Container(
              height: 372,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(product.image, width: 330, height: 200),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      icon: Icon(Icons.ios_share, color: Colors.black),
                      onPressed: () {
                        // Implement share functionality here
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey,
                            size: 23,
                          ),
                          onPressed: () {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: _decrementQuantity,
                              icon: Icon(Icons.remove, color: Colors.grey),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              // padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$_quantity',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _incrementQuantity,
                              icon: Icon(Icons.add, color: _green),
                            ),
                          ],
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Divider(thickness: 1),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Product Detail',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        _isDetailExpanded
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                      ),
                      onTap: () {
                        setState(() {
                          _isDetailExpanded = !_isDetailExpanded;
                        });
                      },
                    ),
                    if (_isDetailExpanded)
                      Text(
                        product.description2,
                        style: TextStyle(color: Colors.grey, height: 1.5),
                      ),
                    Divider(thickness: 1),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Nutritions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFEBEBEB),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Text(
                              product.nutrition,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                    Divider(thickness: 1),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Review',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Icon(Icons.keyboard_arrow_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  print(
                    'Added $_quantity ${product.name} to basket for \$${_totalPrice.toStringAsFixed(2)}',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add To Basket',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(width: 40),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.black12,
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: Text(
                    //     '\$${_totalPrice.toStringAsFixed(2)}',
                    //     style: const TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
