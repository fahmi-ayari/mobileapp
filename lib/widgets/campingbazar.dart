import 'package:flutter/material.dart';
import 'package:campingbazar/widgets/Getstarted.dart';

void main() {
  runApp(const CampingBazzarApp());
}

class CampingBazzarApp extends StatefulWidget {
  const CampingBazzarApp({super.key});

  @override
  State<CampingBazzarApp> createState() => _CampingBazzarScreenState();
}

class _CampingBazzarScreenState extends State<CampingBazzarApp> {
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
