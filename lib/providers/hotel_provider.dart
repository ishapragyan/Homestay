import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/hotel.dart';

class HotelProvider extends ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Hotel> _hotels = [];
  bool _isLoading = false;

  List<Hotel> get hotels => _hotels;
  bool get isLoading => _isLoading;

  Future<void> fetchHotels() async {
    _isLoading = true; // Start loading
    notifyListeners();

    try {
      print("Fetching hotels...");

      final snapshot =  await FirebaseFirestore.instance.collection('hotels').get();


      _hotels = snapshot.docs.map((doc) {
        final data = doc.data();

        return Hotel(
          name: data['name'] ?? 'Unknown Hotel',
          location: data['location'] ?? 'No Location',
          price: (data['price'] as num).toInt(),
          rating: (data['rating'] as num).toDouble(),
          image: data['image'] ?? 'https://via.placeholder.com/150',
        );
      }).toList();

      print("Hotels count: ${snapshot.docs.length}");

      notifyListeners();
    } catch (e) {
      print("Error fetching hotels: $e");
    }

    finally {
      _isLoading = false; // Stop loading
      notifyListeners();
    }
  }
}