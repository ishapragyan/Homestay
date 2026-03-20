import 'package:flutter/material.dart';
import '../models/hotel.dart';



class FavoritesProvider extends ChangeNotifier {

  final List<Hotel> _favorites = [];

  List<Hotel> get favorites => _favorites;

  void addFavorite(Hotel hotel) {
    if (!_favorites.contains(hotel)) {
      _favorites.add(hotel);
      notifyListeners();
    }
  }

  void removeFavorite(Hotel hotel) {
    _favorites.remove(hotel);
    notifyListeners();
  }

  bool isFavorite(Hotel hotel) {
    return _favorites.contains(hotel);
  }

  void toggleFavorite(Hotel hotel) {
    if (isFavorite(hotel)) {
      removeFavorite(hotel);
    } else {
      addFavorite(hotel);
    }
  }
}