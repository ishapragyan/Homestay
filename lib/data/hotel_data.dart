import '../models/hotel.dart';

class HotelData {

  static List<Hotel> hotels = [

    Hotel(
      name: "Ocean View Hotel",
      location: "Bhubaneswar",
      price: 120,
      rating: 4.5,
      image: "https://images.unsplash.com/photo-1566073771259-6a8506099945",
      isFavorite: false, onFavoriteToggle: () {  },
    ),
    Hotel(
      name: "Royal Palace",
      location: "Puri",
      price: 150,
      rating: 4.2,
      image: "https://images.unsplash.com/photo-1551882547-ff40c63fe5fa",
      isFavorite: false, onFavoriteToggle: () {  },
    ),
    Hotel(
      name: "City Comfort",
      location: "Cuttack",
      price: 90,
      rating: 4.0,
      image: "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b",
      isFavorite: false, onFavoriteToggle: () {  },
    ),

  ];

}