import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:groceries_app/helpers/groceries_card.dart';
import 'package:groceries_app/helpers/product_card.dart';
import 'package:groceries_app/models/grocery.dart';
import 'package:groceries_app/models/menu_item.dart';
import 'package:groceries_app/models/product.dart';
import 'package:groceries_app/screens/product_detail.dart';

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
      image: 'assets/images/bananas.png',
      description2:
          'Bananas are a good source of potassium and fiber. They can help improve digestion, support heart health, and provide a quick energy boost.',
      nutrition: '100gr',
    ),
    Product(
      id: 2,
      name: 'Red Apple',
      description: '1Kg, Price',
      price: 4.9999,
      image: 'assets/images/apple.png',
      description2:
          'Apples are rich in antioxidants and dietary fiber. They may help reduce the risk of chronic diseases, support weight management, and promote overall health.',
      nutrition: '250gr',
    ),
    Product(
      id: 3,
      name: 'Organic Carrot',
      description: '100g, Price',
      price: 2.75,
      image: 'assets/images/carrot.png',
      description2:
          'Carrots are high in beta-carotene, which is converted to vitamin A in the body. They support eye health, boost the immune system, and may reduce the risk of certain cancers.',
      nutrition: '250gr',
    ),
    Product(
      id: 4,
      name: 'Orange',
      description: '7pcs, Price',
      price: 6.79,
      image: 'assets/images/orange.png',
      description2:
          'Oranges are an excellent source of vitamin C and antioxidants. They can help strengthen the immune system, improve skin health, and reduce the risk of chronic diseases.',
      nutrition: '150gr',
    ),
  ];
  final List<Product> _bestSelling = [
    Product(
      id: 5,
      name: 'Red Pepper',
      price: 5.75,
      image: 'assets/images/pepper.png',
      description: '1Kg, price',
      description2:
          'Red peppers are rich in vitamin C and antioxidants. They can help boost the immune system, improve skin health, and reduce the risk of chronic diseases.',
      nutrition: '120gr',
    ),
    Product(
      id: 6,
      name: 'Green Apple',
      price: 12.79,
      image: 'assets/images/apple_green.png',
      description: '7pcs, price',
      description2:
          'Green apples are a good source of dietary fiber and vitamin C. They can help improve digestion, support heart health, and provide a quick energy boost.',
      nutrition: '80gr',
    ),
    Product(
      id: 7,
      name: 'Tomato',
      price: 2.79,
      image: 'assets/images/tomato.png',
      description: '7pcs, price',
      description2:
          'Tomatoes are rich in lycopene, an antioxidant that may help reduce the risk of certain cancers. They also support heart health and improve skin health.',
      nutrition: '130gr',
    ),
  ];
  final List<Product> _groceryItems = [
    Product(
      id: 7,
      name: 'Beef',
      price: 20.75,
      image: 'assets/images/beef.png',
      description: '100g, price',
      description2:
          'Beef is a rich source of protein, iron, and vitamin B12. It can help support muscle growth, improve energy levels, and promote overall health.',
      nutrition: '100gr',
    ),
    Product(
      id: 8,
      name: 'Chicken',
      price: 22.79,
      image: 'assets/images/chicken.png',
      description: '1pcs, price',
      description2:
          'Chicken is a good source of lean protein and essential amino acids. It can help support muscle development, improve immune function, and provide sustained energy.',
      nutrition: '110gr',
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
    MenuItem(label: 'Shop', icon: 'assets/images/svg/Shop.svg'),
    MenuItem(label: 'Search', icon: 'assets/images/svg/Search.svg'),
    MenuItem(label: 'Card', icon: 'assets/images/svg/Cart.svg'),
    MenuItem(label: 'Favorite', icon: 'assets/images/svg/Favorite.svg'),
    MenuItem(label: 'Account', icon: 'assets/images/svg/Account.svg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 50, top: 70),
        children: [
          // SizedBox(height: 70),
          Image.asset('assets/icons/carrot_logo.png', height: 30),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.black54, size: 20),
              SizedBox(width: 4),
              Text(
                'Phnom Penh, Cambodia',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
                      child: ProductCard(
                        product: product,
                        // onPressed: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ProductDetailScreen(product: product),
                        //     ),
                        //   );
                        // }
                      ),
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
