import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StayEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> hotels = [
    {
      "name": "Ocean View Hotel",
      "location": "Bhubaneswar",
      "price": 120,
      "rating": 4.5,
      "image":
      "https://images.unsplash.com/photo-1566073771259-6a8506099945"
    },
    {
      "name": "Royal Palace",
      "location": "Puri",
      "price": 150,
      "rating": 4.2,
      "image":
      "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa"
    },
    {
      "name": "City Comfort",
      "location": "Cuttack",
      "price": 90,
      "rating": 4.0,
      "image":
      "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StayEase Hotels"),
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.network(
                hotel["image"],
                width: 60,
                fit: BoxFit.cover,
              ),
              title: Text(hotel["name"]),
              subtitle: Text("${hotel["location"]} • ₹${hotel["price"]}/night"),
              trailing: Text("⭐ ${hotel["rating"]}"),
            ),
          );
        },
      ),
    );
  }
}