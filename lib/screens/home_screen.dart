import 'package:flutter/material.dart';
import '../widgets/hotel_card.dart';
import '../models/hotel.dart';
import 'package:provider/provider.dart';
import '../providers/hotel_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key}); // Added Key

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Set<String> favoriteHotels = {};
  TextEditingController searchController = TextEditingController();
  List<Hotel> displayedHotels = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HotelProvider>(context, listen: false).fetchHotels();
    });
  }

  void toggleFavorite(String hotelName) {
    setState(() {
      if (favoriteHotels.contains(hotelName)) {
        favoriteHotels.remove(hotelName);
      } else {
        favoriteHotels.add(hotelName);
      }
    });
  }

  void searchHotels(String query, List<Hotel> allHotels) {
    final results = allHotels.where((hotel) {
      final name = hotel.name.toLowerCase();
      final location = hotel.location.toLowerCase();
      final input = query.toLowerCase();

      return name.contains(input) || location.contains(input);
    }).toList();

    setState(() {
      displayedHotels = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hotelProvider = Provider.of<HotelProvider>(context);
    final hotels = hotelProvider.hotels; // dynamic
    final displayHotels = searchController.text.isEmpty ? hotels : displayedHotels;
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeStay Hotels"),
      ),
      body: hotelProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                onChanged: (value) => searchHotels(value, hotels),
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
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 300,
                    child: HotelCard(hotel: hotels[index]),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayHotels.length,
              itemBuilder: (context, index) {
                return HotelCard(hotel: displayHotels[index]);
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


    ),
    Hotel(
      name: "Mountain Paradise",
      location: "Manali",
      price: 180,
      rating: 4.7,
      image: "https://images.unsplash.com/photo-1566073771259-6a8506099945",

    ),
  ];
}