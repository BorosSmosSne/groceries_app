import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard2 extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final bool isFavorite;
  final ValueChanged<bool>? onFavoriteChanged;

  const ProductCard2({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.isFavorite = false,
    this.onFavoriteChanged,
  });

  @override
  State<ProductCard2> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard2> {
  late bool _fav;

  static const Color starColor = Color(0xFFFFB800);
  static const Color primaryPriceColor = Color(0xFF1E1E1E);

  @override
  void initState() {
    super.initState();
    _fav = widget.isFavorite;
  }

  @override
  void didUpdateWidget(covariant ProductCard2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite) {
      _fav = widget.isFavorite;
    }
  }

  Widget _buildImage(String? url) {
    final image = (url ?? '').trim();
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return Image.network(
        Uri.encodeFull(image),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => Container(
          color: const Color(0xFFF3F3F3),
          child: const Center(
            child: Icon(Icons.fastfood, size: 36, color: Colors.black26),
          ),
        ),
      );
    }

    return Image.asset(
      image.isNotEmpty ? image : 'assets/images/imagelist1.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => Container(
        color: const Color(0xFFF3F3F3),
        child: const Center(
          child: Icon(Icons.fastfood, size: 36, color: Colors.black26),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias, // Clips image flush to top corners
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. FULL-BLEED IMAGE WITH FLOATING HEART
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildImage(widget.product.imageUrl),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _fav = !_fav);
                        widget.onFavoriteChanged?.call(_fav);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.88),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          _fav ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: _fav ? Colors.red : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. CARD FOOTER: NAME, RATING, PRICE & CIRCULAR BUTTON
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Product Title & Star Rating Row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1E1E1E),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star_rounded,
                          color: starColor,
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ],
                    ),

                    // Price & Circular Black Button (+)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: primaryPriceColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onAddToCart,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E1E1E),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
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
