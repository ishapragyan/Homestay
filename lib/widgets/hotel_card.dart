import 'package:flutter/material.dart';
import '../screens/hotel_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../models/hotel.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;


  const HotelCard({
    super.key,
    required this.hotel,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HotelDetailsScreen(hotel: hotel),
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
            tag: hotel.image,
            child: Image.network(
              hotel.image,
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
                  hotel.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(hotel.location),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "₹${hotel.price}/night",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        Text("⭐ ${hotel.rating}"),
                        const SizedBox(width: 10),

                        Consumer<FavoritesProvider>(
                          builder: (context, favProvider, child) {
                            final isFav = favProvider.isFavorite(hotel);

                            return GestureDetector(
                              onTap: () {
                                favProvider.toggleFavorite(hotel);
                              },
                              child: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                            );
                          },
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