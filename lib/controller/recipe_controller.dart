import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipieapp/model/recipe_model.dart';
import 'package:recipieapp/services/recipe_services.dart';

class RecipeController extends ChangeNotifier {
  RecipeServices recipeServices = RecipeServices();
  List<RecipeModel> recipes = [];
  void getRecipes() async {
    try {
      recipes = await recipeServices.getRecipes();
      log(recipes.toString());
      if (recipes.isEmpty) {
        log('No data');
      } else {
        log('Data found');
      }
    } catch (e) {
      log(e.toString());
    }

    notifyListeners();
  }
}
