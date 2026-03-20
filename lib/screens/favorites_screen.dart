import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/hotel_card.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favProvider, child) {

          final favorites = favProvider.favorites;

          if (favorites.isEmpty) {
            return const Center(
              child: Text("No favorites yet"),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {

              final hotel = favorites[index];

              return HotelCard(
                  hotel: hotel,
              );
            },
          );
        },
      )
    );
  }
}