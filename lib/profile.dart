import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // User's Photo and Name Section
          const SizedBox(height: 30),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/images/user.jpg'), // User's profile picture
              backgroundColor: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Ahmed Ben Salah", // Fake user name
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "ahmed.bensalah@example.com", // Fake email
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),

          // Settings Options
          Expanded(
            child: ListView(
              children: [
                _buildSettingItem(
                  context,
                  icon: Icons.person,
                  title: "Change Username",
                  onTap: () {
                    // Implement functionality to change username
                  },
                ),
                _buildSettingItem(
                  context,
                  icon: Icons.lock,
                  title: "Change Password",
                  onTap: () {
                    // Implement functionality to change password
                  },
                ),
                _buildSettingItem(
                  context,
                  icon: Icons.notifications,
                  title: "Notifications",
                  onTap: () {
                    // Implement functionality for notifications settings
                  },
                ),
                _buildSettingItem(
                  context,
                  icon: Icons.help,
                  title: "Help & Support",
                  onTap: () {
                    // Implement functionality for help
                  },
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                // Log Out Button at the Bottom
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(color: Colors.redAccent, fontSize: 18),
                  ),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable widget for settings options
  Widget _buildSettingItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.yellow),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Log Out Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Log Out", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context)
                    .pushReplacementNamed('/login'); // Replace with login page
              },
            ),
          ],
        );
      },
    );
  }
}
