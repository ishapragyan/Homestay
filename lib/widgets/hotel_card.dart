// lib/widgets/hotel_card.dart
import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../screens/hotel_details_screen.dart';
import '../providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool isHorizontal;

  const HotelCard({super.key, required this.hotel, this.isHorizontal = false});
  Color _getRatingColor(double rating) {
    if (rating >= 4.0) {
      return Colors.green;
    } else if (rating >= 3.0) {
      return Colors.yellow[700]!; // A slightly darker yellow for better visibility
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HotelDetailsScreen(hotel: hotel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: hotel.image,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network(
                      hotel.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // --- ADDED RATING BADGE (TOP LEFT) ---
                Positioned(
                  top: 15,
                  left: 15,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      // Uses your green/yellow/red logic
                      color: _getRatingColor(hotel.rating).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.white),
                        Text(
                          " ${hotel.rating}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //  Favorite Button (TOP RIGHT)
                Positioned(
                  top: 15,
                  right: 15,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, favProvider, child) {
                      final isFavorite = favProvider.isFavorite(hotel);
                      return GestureDetector(
                        onTap: () => favProvider.toggleFavorite(hotel),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            // Adding a small shadow makes the white button visible on light images
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : const Color(0xFF002366),
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.name, //
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF002366), // Royal Navy Blue
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(hotel.location, style: const TextStyle(color: Colors.grey)), //
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "₹${hotel.price}", //
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF002366),
                              ),
                            ),
                            const TextSpan(
                                text: " /night",
                                style: TextStyle(color: Colors.grey, fontSize: 14)
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF002366).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFF002366)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}