import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
