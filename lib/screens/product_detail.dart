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
  bool _isDetailExpanded = true;

  static const _green = Color(0xFF4CAF50);

  static const _detailText =
      'Apples are nutritious. Apples may be good for weight '
      'loss. Apples may be good for your heart. As part of a '
      'healthful and varied diet.';

  void _incrementQuantity() => setState(() => _quantity++);

  void _decrementQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  // NOTE: _totalPrice has been completely removed!

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ---- Image header ----
            Stack(
              children: [
                Container(
                  height: 320,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(28),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(28),
                    ),
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported, size: 64),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context, 'Add To Basket'),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.ios_share),
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            // ---- Content ----
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () =>
                              setState(() => _isFavorite = !_isFavorite),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // In this model, `description` holds the unit label
                    // (e.g. "1Kg, Price"), same as it's used in ProductCard.
                    Text(
                      product.description,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 16),

                    // ---- Quantity + price ----
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            _qtyButton(Icons.remove, _decrementQuantity),
                            Container(
                              width: 48,
                              alignment: Alignment.center,
                              child: Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            _qtyButton(
                              Icons.add,
                              _incrementQuantity,
                              filled: false,
                              iconColor: _green,
                            ),
                          ],
                        ),
                        Text(
                          // NOTE: Now displaying the fixed product price directly!
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(height: 1),

                    // ---- Product Detail (expandable) ----
                    _sectionHeader(
                      title: 'Product Detail',
                      expanded: _isDetailExpanded,
                      onTap: () => setState(
                        () => _isDetailExpanded = !_isDetailExpanded,
                      ),
                    ),
                    if (_isDetailExpanded)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 4),
                        child: Text(
                          _detailText,
                          style: TextStyle(color: Colors.grey, height: 1.4),
                        ),
                      ),
                    const Divider(height: 1),

                    _sectionHeader(
                      title: 'Nutritions',
                      trailing: const Text(
                        '100g',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      onTap: () {},
                    ),
                    const Divider(height: 1),

                    _sectionHeader(
                      title: 'Review',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (i) => const Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                            size: 18,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ---- Add to Basket ----
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () {
              Navigator.pop(context, 'Add To Basket');
              print('successfully added to basket');
            },

            child: const Text(
              'Add To Basket',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _qtyButton(
    IconData icon,
    VoidCallback onPressed, {
    bool filled = true,
    Color iconColor = Colors.black,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }

  Widget _sectionHeader({
    required String title,
    Widget? trailing,
    bool? expanded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            trailing ??
                Icon(
                  expanded == true
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
          ],
        ),
      ),
    );
  }
}
