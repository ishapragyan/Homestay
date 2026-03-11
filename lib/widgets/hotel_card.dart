import 'package:flutter/material.dart';
import '../screens/hotel_details_screen.dart';
import '../models/hotel.dart';

class HotelCard extends StatelessWidget {
  final String name;
  final String location;
  final int price;
  final double rating;
  final String image;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const HotelCard({
    Key? key,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetailsScreen(
                name: name,
                location: location,
                price: price,
                rating: rating,
                image: image,
              ),
            ),
          );
        },
        child: Card(

      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: image,
            child: Image.network(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(location),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "₹$price/night",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        Text("⭐ $rating"),
                        SizedBox(width: 10),

                        GestureDetector(
                          onTap: onFavoriteToggle,
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}