import 'package:flutter/material.dart';
import '../widgets/hotel_card.dart';
import '../models/hotel.dart';
import '../data/hotel_data.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<String> favoriteHotels = {};
  void toggleFavorite(String hotelName) {
    setState(() {
      if (favoriteHotels.contains(hotelName)) {
        favoriteHotels.remove(hotelName);
      } else {
        favoriteHotels.add(hotelName);
      }
    });
  }
  TextEditingController searchController = TextEditingController();
  List<Hotel> filteredHotels = [];
  @override
  void initState() {
    super.initState();
    filteredHotels = hotels;
  }void searchHotels(String query) {
    final results = hotels.where((hotel) {
      final name = hotel.name.toLowerCase();
      final location = hotel.location.toLowerCase();
      final input = query.toLowerCase();

      return name.contains(input) || location.contains(input);
    }).toList();

    setState(() {
      filteredHotels = results;
    });
  }
  final hotels = HotelData.hotels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StayEase Hotels"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SEARCH BAR
            Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search hotels or cities",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: searchHotels,
              ),
            ),

            // FEATURED TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Featured Hotels",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            // FEATURED HOTELS HORIZONTAL LIST
            SizedBox(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = featuredHotels[index];

                  return SizedBox(
                    width: 300,
                    child: HotelCard(
                      name: hotel.name,
                      location: hotel.location,
                      price: hotel.price,
                      rating: hotel.rating,
                      image: hotel.image,
                      isFavorite: favoriteHotels.contains(hotel.name),
                      onFavoriteToggle: () => toggleFavorite(hotel.name),
                    )
                    );

                },
              ),
            ),

            SizedBox(height: 20),

            // ALL HOTELS TITLE
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "All Hotels",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // HOTEL LIST
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];

                return HotelCard(
                  name: hotel.name,
                  location: hotel.location,
                  price: hotel.price,
                  rating: hotel.rating,
                  image: hotel.image,
                  // These are the new requirements:
                  isFavorite: favoriteHotels.contains(hotel.name),
                  onFavoriteToggle: () => toggleFavorite(hotel.name),


                );
              },
            ),
          ],
        ),
      ),
    );
  }
  final List<Hotel> featuredHotels = [
    Hotel(
      name: "Luxury Sea Resort",
      location: "Goa",
      price: 220,
      rating: 4.8,
      image: "https://images.unsplash.com/photo-1571896349842-33c89424de2d",
      isFavorite: false, onFavoriteToggle: () {  },

    ),
    Hotel(
      name: "Mountain Paradise",
      location: "Manali",
      price: 180,
      rating: 4.7,
      image: "https://images.unsplash.com/photo-1566073771259-6a8506099945",
      isFavorite: false, onFavoriteToggle: () {  },
    ),
  ];
}