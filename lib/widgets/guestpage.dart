import 'package:flutter/material.dart';
import 'package:campingbazar/widgets/signin.dart';

void mainn() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GuestPage(),
  ));
}

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  int _selectedIndex = 0; // Current index for the bottom navigation bar

  final List<Widget> _pages = [
    const ProductGridPage(), // Home page
    const SizedBox(), // Placeholder for Favorites page
    const SizedBox(), // Placeholder for Add page
    const SizedBox(), // Placeholder for Messages page
    const SizedBox(), // Placeholder for Profile page
  ];

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
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.grey,
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
    );
  }
}

class ProductGridPage extends StatelessWidget {
  const ProductGridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Products🔥",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final String seller;
  final String imageUrl;
  final double price;
  bool isLiked; // Track if the product is liked

  Product({
    required this.name,
    required this.seller,
    required this.imageUrl,
    required this.price,
    this.isLiked = false, // Default to not liked
  });
}

final List<Product> products = [
  Product(
    name: "Camping Chair",
    seller: "Ahmed ben Echikh",
    imageUrl:
        "https://cdn.hepsiglobal.com/prod/media/23198/20240903/71fab4e5-71b7-4061-a61f-01b29679de23.jpg",
    price: 195.00,
  ),
  Product(
    name: "Camping Tent",
    seller: "Nermin Sanaa",
    imageUrl:
        "https://th.bing.com/th/id/OIP.cqTzyxOEtXnlCXOBp1fbZQHaHa?rs=1&pid=ImgDetMain",
    price: 143.45,
  ),
  Product(
    name: "Camping Tent",
    seller: "Nermin Sanaa",
    imageUrl:
        "https://th.bing.com/th/id/OIP.cqTzyxOEtXnlCXOBp1fbZQHaHa?rs=1&pid=ImgDetMain",
    price: 143.45,
  ),
  Product(
    name: "Camping Tent",
    seller: "Nermin Sanaa",
    imageUrl:
        "https://th.bing.com/th/id/OIP.cqTzyxOEtXnlCXOBp1fbZQHaHa?rs=1&pid=ImgDetMain",
    price: 143.45,
  ),
  Product(
    name: "Camping Tent",
    seller: "Nermin Sanaa",
    imageUrl:
        "https://th.bing.com/th/id/OIP.cqTzyxOEtXnlCXOBp1fbZQHaHa?rs=1&pid=ImgDetMain",
    price: 143.45,
  ),
  Product(
    name: "Camping Tent",
    seller: "Nermin Sanaa",
    imageUrl:
        "https://th.bing.com/th/id/OIP.cqTzyxOEtXnlCXOBp1fbZQHaHa?rs=1&pid=ImgDetMain",
    price: 143.45,
  ),
];

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
    return GestureDetector(
      onTap: () {
        // Navigate to the Sign In page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      },
      child: Container(
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
                // Product Seller
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    widget.product.seller,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
                // Product Price
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${widget.product.price.toStringAsFixed(2)} DT",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
                  widget.product.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.product.isLiked ? Colors.red : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
