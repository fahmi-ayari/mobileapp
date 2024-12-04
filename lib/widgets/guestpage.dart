import 'package:flutter/material.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  int _selectedIndex = 0; // Current index for the bottom navigation bar
  String _searchQuery = '';
  bool _isSearching = false;

  final List<Product> _allProducts = [
    Product(
      name: 'Camping Chair',
      category: 'Chairs',
      price: 195.00,
      imageUrl:
          'https://cdn.hepsiglobal.com/prod/media/23198/20240903/71fab4e5-71b7-4061-a61f-01b29679de23.jpg',
    ),
    Product(
      name: 'Camping Tent',
      category: 'Tents',
      price: 143.45,
      imageUrl:
          'https://th.bing.com/th/id/OIP.cqTzyxOEtXnlCXOBp1fbZQHaHa?pid=ImgDet&rs=1',
    ),
    Product(
      name: 'Sleeping Bag',
      category: 'Sleeping Bags',
      price: 99.99,
      imageUrl:
          'https://th.bing.com/th/id/OIP.oI5MggmlFZR6XrTO3hLE3wHaHa?pid=ImgDet&rs=1',
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
      _filteredProducts = _allProducts.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    if (index != 0) {
      // Redirect to Sign In Page for all tabs except Home
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const Center(child: Text("Sign In Placeholder"))),
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
              color: Colors.yellow,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: _filteredProducts.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return ProductCard(product: product);
                },
              )
            : const Center(
                child: Text(
                  'No products found',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
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
          unselectedItemColor: Colors.white,
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

class Product {
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  bool isLiked = false;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });
}

class ProductCard extends StatefulWidget {
  final Product product;

  const ProductCard({required this.product, super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  void toggleLike() {
    setState(() {
      widget.product.isLiked = !widget.product.isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  widget.product.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              // Product Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Product Category and Price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "${widget.product.category} - ${widget.product.price.toStringAsFixed(2)} DT",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          // Heart Icon at the Bottom Right
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: toggleLike,
              child: Icon(
                widget.product.isLiked ? Icons.favorite : Icons.favorite_border,
                color: widget.product.isLiked ? Colors.red : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
