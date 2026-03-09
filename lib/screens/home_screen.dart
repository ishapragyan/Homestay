import 'package:flutter/material.dart';
import '../widgets/hotel_card.dart';
import '../models/hotel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  final List<Hotel> hotels = [

    Hotel(
      name: "Ocean View Hotel",
      location: "Bhubaneswar",
      price: 120,
      rating: 4.5,
      image: "https://images.unsplash.com/photo-1566073771259-6a8506099945",
    ),
    Hotel(
      name: "Royal Palace",
      location: "Puri",
      price: 150,
      rating: 4.2,
      image: "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa",
    ),
    Hotel(
      name: "City Comfort",
      location: "Cuttack",
      price: 90,
      rating: 4.0,
      image: "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StayEase Hotels"),
      ),
      body: Column(
        children: [

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

          Expanded(
            child: ListView.builder(
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];

                return HotelCard(
                  name: hotel.name,
                  location: hotel.location,
                  price: hotel.price,
                  rating: hotel.rating,
                  image: hotel.image,
                );
              },
            ),
          )

        ],
      ),
    );
  }
}