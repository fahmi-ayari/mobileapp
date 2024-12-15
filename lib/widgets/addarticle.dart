import 'package:flutter/material.dart';

class AddArticlePage extends StatefulWidget {
  const AddArticlePage({super.key});

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  String selectedCategory = "Chairs";
  final List<String> categories = ["Chairs", "Tents", "Sleeping Bags", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add Article",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image Upload
            GestureDetector(
              onTap: () {
                // Implement image picker logic
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text("Feature Coming Soon"),
                    content: Text("Image upload will be available soon."),
                  ),
                );
              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: const Center(
                  child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Article Name Field
            TextField(
              style: TextStyle(color: Colors.white),
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Article Name",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Category",
                labelStyle: TextStyle(color: Colors.grey),
                // Label text in white
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.yellow),
                ),
              ),
              dropdownColor: Colors.black, // Dropdown menu background color
              style: TextStyle(color: Colors.white), // Selected text color
              items: categories
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: TextStyle(
                              color: Colors.white), // Dropdown items text color
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                // Handle category selection here
                print("Selected category: $value");
              },
            ),

            const SizedBox(height: 16),
            // Price Field
            TextField(
              style: TextStyle(color: Colors.white),
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Price (DT)",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Description Field
            TextField(
              style: TextStyle(color: Colors.white),
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Contact Information Field
            TextField(
              style: TextStyle(color: Colors.white),
              controller: contactController,
              decoration: InputDecoration(
                labelText: "Contact Information",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Implement article submission logic
                  if (nameController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      contactController.text.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Article '${nameController.text}' added successfully!"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill in all required fields!"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Add Article",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
