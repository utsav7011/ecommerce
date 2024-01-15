import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoritesNotifier extends ChangeNotifier {
  final _fav_box = Hive.box('fav_box');

  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];

  List<dynamic> get ids => _ids;

  setids(List<dynamic> newIds) {
    _ids = newIds;
    notifyListeners();
  }

  List<dynamic> get favorites => _favorites;

  setFavorites(List<dynamic> newfavorites) {
    _favorites = newfavorites;
    notifyListeners();
  }

  getFavourites() {
    final favData = _fav_box.keys.map((key) {
      final item = _fav_box.get(key);
      return {
        "key": key,
        "id": "id",
      };
    }).toList();

    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
  }
}
