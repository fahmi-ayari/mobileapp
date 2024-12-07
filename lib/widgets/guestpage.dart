import 'package:flutter/material.dart';
import 'package:campingbazar/widgets/productlist.dart';
import 'package:campingbazar/widgets/signin.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  int _selectedIndex = 0; // Current index for the bottom navigation bar
  String _searchQuery = '';
  bool _isSearching = false;
  String _searchType = 'name'; // Default search type

  final List<Product> _allProducts = [
    Product(
      name: 'Camping Chair',
      owner: 'ahmed ben echikh',
      category: 'Chairs',
      price: 195.00,
      imageUrl:
          'https://cdn.hepsiglobal.com/prod/media/23198/20240903/71fab4e5-71b7-4061-a61f-01b29679de23.jpg',
    ),
    Product(
      name: 'Camping Tent',
      owner: 'nermine sanaa',
      category: 'Tents',
      price: 143.45,
      imageUrl:
          'https://th.bing.com/th/id/OIP.kDwjgW1AikkIooKUH99XiAHaHa?rs=1&pid=ImgDetMain',
    ),
    Product(
      name: 'Sleeping Bag',
      owner: 'ahmed ben echikh',
      category: 'Sleeping Bags',
      price: 99.99,
      imageUrl:
          'https://th.bing.com/th/id/OIP.it7_a1Az2WdPwOdriO4p_gHaJ4?w=750&h=1000&rs=1&pid=ImgDetMai',
    ),
  ];

  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_allProducts); // Start with all products
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      if (_searchType == 'name') {
        _filteredProducts = _allProducts.where((product) {
          return product.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else if (_searchType == 'category') {
        _filteredProducts = _allProducts.where((product) {
          return product.category.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else if (_searchType == 'price') {
        _filteredProducts = _allProducts.where((product) {
          return product.price
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _onItemTapped(int index) {
    if (index != 0) {
      // Redirect to Sign In Page for all tabs except Home
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
      );
    } else {
      setState(() {
        _selectedIndex = index; // Update selected index for Home
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        title: _isSearching
            ? TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : const Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchQuery = '';
                  _filteredProducts = List.from(_allProducts);
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _searchType = 'category';
                        _filteredProducts = List.from(_allProducts);
                        _searchQuery = '';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _searchType == 'category'
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                    child: const Text(
                      'Search by Category',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _searchType = 'price';
                        _filteredProducts = List.from(_allProducts);
                        _searchQuery = '';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _searchType == 'price' ? Colors.yellow : Colors.grey,
                    ),
                    child: const Text(
                      'Order by Price',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _filteredProducts.isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()),
                            );
                          },
                          child: ProductCard(product: product),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No products found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.yellow,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: Colors.red),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
