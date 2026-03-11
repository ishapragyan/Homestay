import 'package:flutter/material.dart';

class HotelDetailsScreen extends StatelessWidget {
  final String name;
  final String location;
  final int price;
  final double rating;
  final String image;

  const HotelDetailsScreen({
    Key? key,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: image,
            child: Image.network(
              image,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 50); // Fallback icon
              },
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "⭐ $rating",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 10),

                Text(
                  "₹$price per night",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Book Now"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}