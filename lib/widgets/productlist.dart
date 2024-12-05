import 'package:flutter/material.dart';

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

final List<Product> products = [
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
