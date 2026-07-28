import 'dart:math';

import 'package:flutter/material.dart';
import 'package:groceries_app/models/grocery.dart';

class GroceriesCard extends StatelessWidget {
  // We add these variables so the card can change dynamically
  final Grocery grocery;

  const GroceriesCard({super.key, required this.grocery});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240, // Keeps the cards a consistent width
      height: 100,
      decoration: BoxDecoration(
        color: Color.fromRGBO(
          Random().nextInt(255),
          Random().nextInt(255),
          Random().nextInt(255),
          0.15,
        ),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Expanded forces the text to take up the left side
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                grocery.name, // Uses the text you pass in
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          // The image on the right side
          Image.asset(
            grocery.imagePath, // Uses the image path you pass in
            width: 90,
            height: 90,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 16), // Adds a tiny gap on the right edge
        ],
      ),
    );
  }
}
