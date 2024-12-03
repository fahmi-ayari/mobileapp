import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package to your pubspec.yaml
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const CampingBazzarApp());
}

class CampingBazzarApp extends StatelessWidget {
  const CampingBazzarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CampingBazzarScreen(),
    );
  }
}

class CampingBazzarScreen extends StatefulWidget {
  const CampingBazzarScreen({super.key});

  @override
  State<CampingBazzarScreen> createState() => _CampingBazzarScreenState();
}

class _CampingBazzarScreenState extends State<CampingBazzarScreen> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Fullscreen Background Image
            Positioned.fill(
              child: Image.network(
                'https://media.timeout.com/images/105658195/image.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Overlay Content
            Column(
              children: [
                const Spacer(), // Push content to the center
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "CampingBazzar",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Space between title and subtitle
                      const Text(
                        "Shop all your camping essentials\nfrom the comfort of home",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Push the content above the button
                MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: GestureDetector(
                    onTap: () {
                      // Navigation to another page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NextPage()),
                      );
                    },
                    child: AnimatedScale(
                      scale: _isHovered ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space at the bottom
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Next Page

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: PageTow());
  }
}

class PageTow extends StatefulWidget {
  const PageTow({super.key});

  @override
  State<PageTow> createState() => _NextPageState();
}

class _NextPageState extends State<PageTow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'https://hk.bigpack.com/cdn/shop/products/IMG_6245_1024x.jpg?v=1616839831',
    'https://newellbrands.imgix.net/229d573e-bece-31b1-9b8f-d28016e726df/229d573e-bece-31b1-9b8f-d28016e726df.jpg?fm=jpg',
    'https://th.bing.com/th/id/OIP.oi5eAZ6kSve7l9JIORjaxwHaFj?w=800&h=600&rs=1&pid=ImgDetMain',
  ];

  final List<String> _texts = [
    "Experience the ultimate outdoor comfort",
    "Make every camping trip unforgettable",
    "Embark on your next adventure with the ultimate camping essentials",
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Image Carousel
          SizedBox(
            height: 350,
            width: 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    _images[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Page Indicators
          SmoothPageIndicator(
            controller: _pageController,
            count: _images.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: Colors.yellow,
              dotColor: Colors.grey,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 8,
            ),
          ),
          const SizedBox(height: 20),
          // Text Description
          Text(
            _texts[_currentPage],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          // Create Account Button
          // Create Account Button
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateAccountPage()),
                );
              },
              child: Container(
                width: 350, // Reduced width for the button
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius:
                      BorderRadius.circular(10), // Updated for rounded edges
                ),
                child: const Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
              height: 20), // Space between Create Account and other options
          // Already Have an Account
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                child: const Text(
                  "Already Have an Account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Additional space
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GuestPage()),
                  );
                },
                child: const Text(
                  "Continue as a Guest",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20), // Final spacing at the bottom
        ],
      ),
    );
  }
}

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30), // Spacing at the top
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 30),

              // Username Input
              const InputField(
                label: "Username",
                hintText: "Create your username",
                icon: Icons.person,
              ),
              const SizedBox(height: 20),

              // Email or Phone Number Input
              const InputField(
                label: "Email or Phone Number",
                hintText: "Enter your email or phone number",
                icon: Icons.email,
              ),
              const SizedBox(height: 20),

              // Password Input
              const InputField(
                label: "Password",
                hintText: "Create your password",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 30),

              // Create Account Button
              GestureDetector(
                onTap: () {
                  // Add Create Account logic here
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Create Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Divider Text
              const Center(
                child: Text(
                  "Or using other method",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 20),

              // Social Login Buttons
              SocialLoginButton(
                text: "Sign Up with Google",
                icon: FontAwesomeIcons
                    .google, // Use FontAwesomeIcons or custom asset
                color: Colors.white,
                textColor: Colors.black,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                text: "Sign Up with Facebook",
                icon: Icons.facebook,
                color: Colors.blue,
                textColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(height: 30), // Bottom spacing
            ],
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const InputField({
    required this.label,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade800,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white54),
            prefixIcon: Icon(icon, color: Colors.white54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap; // To handle onTap actions

  const SocialLoginButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Use the onTap callback
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )),
      resizeToAvoidBottomInset:
          true, // Ensures the UI resizes when the keyboard appears
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const SizedBox(height: 20), // Add space at the top
              const Text(
                "User name",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      hintText: "User name or Email",
                      hintStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ))),
              const SizedBox(height: 50), // Add space at the top
              const Text(
                "Create your password",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // Password Input
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade800,
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off,
                    color: Colors.white54,
                  ),
                ),
                obscureText: true,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Add Forgot Password logic here
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.yellow),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign In Button
              GestureDetector(
                onTap: () {
                  // Add Sign In logic here
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Other Methods
              const Center(
                child: Text(
                  "Or using other method",
                  style: TextStyle(color: Colors.white54),
                ),
              ),
              const SizedBox(height: 20),

              // Social Login Buttons
              SocialLoginButton(
                text: "Sign Up with Google",
                icon: FontAwesomeIcons
                    .google, // Use FontAwesomeIcons or custom asset
                color: Colors.white,
                textColor: Colors.black,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              SocialLoginButton(
                text: "Sign Up with Facebook",
                icon: Icons.facebook,
                color: Colors.blue,
                textColor: Colors.white,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              // Add additional options here (e.g., social media buttons)
            ],
          ),
        ),
      ),
    );
  }
}

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
