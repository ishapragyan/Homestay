import 'package:flutter/material.dart';
import 'package:homestay/models/hotel.dart';

class HotelDetailsScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailsScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: hotel.image,
            child: Image.network(
              hotel.image,
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
                  hotel.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  hotel.location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "⭐ ${hotel.rating}",
                  style: TextStyle(fontSize: 16),
                ),

                SizedBox(height: 10),

                Text(
                  "₹${hotel.price} per night",
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