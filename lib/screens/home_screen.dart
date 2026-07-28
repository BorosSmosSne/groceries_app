import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groceries_app/helpers/product_card.dart';
import 'package:groceries_app/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlideIndex = 0;
  final List<Product> _products = [
    Product(
      id: 1,
      name: 'Organic Banana',
      description: '7pcs, Price',
      price: 4.9999,
      image: 'assets/images/bananas.jpg',
    ),
    Product(
      id: 2,
      name: 'Red Apple',
      description: '1Kg, Price',
      price: 4.9999,
      image: 'assets/images/apple.png',
    ),
    Product(
      id: 3,
      name: 'Organic Carrot',
      description: '100g, Price',
      price: 2.75,
      image: 'assets/images/carrot.png',
    ),
    Product(
      id: 4,
      name: 'Orange',
      description: '7pcs, Price',
      price: 6.79,
      image: 'assets/images/orange.png',
    ),
  ];
  final List<String> _slider = [
    'assets/images/B1.png',
    'assets/images/B1.png',
    'assets/images/B1.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 16, bottom: 16),
            child: CupertinoSearchTextField(
              style: TextStyle(
                fontFamily: 'Poppin',
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Icon(CupertinoIcons.search),
              padding: EdgeInsets.all(16),
            ),
          ),
          CarouselSlider(
            items: _slider
                .map(
                  (slider) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        slider,
                        fit: BoxFit.cover,
                        // width: double.infinity,
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 120,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                currentSlideIndex = index;
                setState(() {});
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Exclusive Offer',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: _products
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: product),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton.extended(onPressed: () {}),
    );
  }
}
