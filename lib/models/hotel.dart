import 'package:flutter/foundation.dart';

class Hotel {
  final String name;
  final String location;
  final int price;
  final double rating;
  final String image;

  Hotel({
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.image,
  });
}