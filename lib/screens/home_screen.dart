import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:groceries_app/helpers/groceries_card.dart';
import 'package:groceries_app/helpers/product_card.dart';
import 'package:groceries_app/models/grocery.dart';
import 'package:groceries_app/models/menu_item.dart';
import 'package:groceries_app/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlideIndex = 0;
  final List<Product> _exlusiveOffers = [
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
  final List<Product> _bestSelling = [
    Product(
      id: 5,
      name: 'Red Pepper',
      price: 5.75,
      image: 'assets/images/pepper.png',
      description: '1Kg, price',
    ),
    Product(
      id: 6,
      name: 'Green Apple',
      price: 12.79,
      image: 'assets/images/apple_green.png',
      description: '7pcs, price',
    ),
    Product(
      id: 7,
      name: 'Tomato',
      price: 2.79,
      image: 'assets/images/tomato.png',
      description: '7pcs, price',
    ),
  ];
  final List<Product> _groceryItems = [
    Product(
      id: 7,
      name: 'Beef',
      price: 20.75,
      image: 'assets/images/beef.png',
      description: '100g, price',
    ),
    Product(
      id: 8,
      name: 'Chicken',
      price: 22.79,
      image: 'assets/images/chicken.png',
      description: '1pcs, price',
    ),
  ];
  final List<String> _slider = [
    'assets/images/B1.png',
    'assets/images/B2.jpg',
    'assets/images/B7.jpg',
  ];
  final List<Grocery> _groceries = [
    Grocery(id: '1', imagePath: 'assets/images/pulses1.png', name: 'Pulses'),
    Grocery(id: '2', imagePath: 'assets/images/rices.png', name: 'Rices'),
  ];
  final List<MenuItem> _menus = [
    MenuItem(label: 'Shop', icon: 'assets/images/svg/shop.svg'),
    MenuItem(label: 'Search', icon: 'assets/images/svg/search.svg'),
    MenuItem(label: 'Card', icon: 'assets/images/svg/cart.svg'),
    MenuItem(label: 'Favorite', icon: 'assets/images/svg/favorite.svg'),
    MenuItem(label: 'Account', icon: 'assets/images/svg/account.svg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 20),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 16,
              bottom: 16,
              right: 20,
            ),
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
          SizedBox(height: 10),
          Align(alignment: Alignment.bottomCenter, child: buildIndicators()),
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
              children: _exlusiveOffers
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: product),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Best Selling',
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
              children: _bestSelling
                  .map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(product: product),
                    ),
                  )
                  .toList(),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Best Selling',
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
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (int i = 0; i < _groceries.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GroceriesCard(grocery: _groceries[i]),
                  ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 220,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: _groceryItems
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          for (int index = 0; index < _menus.length; index++)
            BottomNavigationBarItem(
              icon: ImageIcon(Svg(_menus[index].icon)),
              label: _menus[index].label,
            ),
        ],
      ),

      // floatingActionButton: FloatingActionButton.extended(onPressed: () {}),
    );
  }

  Row buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < _slider.length; i++)
          AnimatedContainer(
            duration: Duration(milliseconds: 600),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: currentSlideIndex == i ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
            // margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            margin: EdgeInsets.only(right: i == _slider.length - 1 ? 0 : 8),
          ),
      ],
    );
  }
}
