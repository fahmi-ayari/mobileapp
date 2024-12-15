import 'package:flutter/material.dart';
import 'dart:async';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package to your pubspec.yaml
import 'package:campingbazar/widgets/createaccount.dart';
import 'package:campingbazar/widgets/signin.dart';
import 'package:campingbazar/widgets/guestpage.dart';

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
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
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
