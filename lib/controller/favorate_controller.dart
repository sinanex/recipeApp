import 'package:flutter/material.dart';
import 'package:recipieapp/model/recipe_model.dart';
import 'package:recipieapp/services/fav_services.dart';

class FavorateController extends ChangeNotifier {
  FavoriteService favoriteService = FavoriteService();
  List<RecipeModel> recipeModel = [];
  bool isFav = false;
  Color color = Colors.grey;
  void getData() async {
    try {
      recipeModel = await favoriteService.getFav();
    } catch (e) {}
    notifyListeners();
  }

  void favButton(RecipeModel data) {
    if (isFav) {
      favoriteService.addFav(data);
      isFav = !isFav;
      color =    Colors.red;
    } else {
      favoriteService.removeFav(data.id ?? '');
      isFav = !isFav;
            color =    Colors.grey;
    }
    notifyListeners();
  }
}
