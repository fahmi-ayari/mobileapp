import 'package:flutter/material.dart';
import 'package:campingbazar/widgets/SocialLoginButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
