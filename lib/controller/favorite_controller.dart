import 'package:get_storage/get_storage.dart';

class FavoriteHelper {
  final GetStorage _box = GetStorage();

  List<Map<String, dynamic>> _favorites = [];

  FavoriteHelper() {
    loadFavorites();
  }

  void loadFavorites() {
    var storedFavorites = _box.read<List<dynamic>>('favorites') ?? [];
    _favorites = storedFavorites.map((item) {
      if (item is Map<String, dynamic>) {
        return item;
      } else {
        return <String, dynamic>{};
      }
    }).toList();
  }

  void toggleFavorite(String name, String image) {
    Map<String, dynamic> favoriteItem = {
      "name": name,
      "image": image,
    };

    int index = _favorites.indexWhere((item) => item['name'] == name);

    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(favoriteItem);
    }

    _box.write('favorites', _favorites);
    loadFavorites();
  }

  bool isFavorite(String name) {
    return _favorites.any((item) => item['name'] == name);
  }

  List<Map<String, dynamic>> get favorites => _favorites;
}
