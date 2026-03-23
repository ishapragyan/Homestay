// lib/models/hotel.dart

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Hotel &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              location == other.location;

  @override
  int get hashCode => name.hashCode ^ location.hashCode;
}