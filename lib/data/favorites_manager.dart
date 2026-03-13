import '../models/hotel.dart';

class FavoritesManager {

  static final List<Hotel> _favorites = [];

  static List<Hotel> getFavorites() {
    return _favorites;
  }

  static void addFavorite(Hotel hotel) {
    if (!_favorites.contains(hotel)) {
      _favorites.add(hotel);
    }
  }

  static void removeFavorite(Hotel hotel) {
    _favorites.remove(hotel);
  }

  static bool isFavorite(Hotel hotel) {
    return _favorites.contains(hotel);
  }

}