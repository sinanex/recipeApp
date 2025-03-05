import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipieapp/model/comments.dart';
import 'package:recipieapp/model/recipe_model.dart';
import 'package:recipieapp/services/recipe_services.dart';

class RecipeController extends ChangeNotifier {
  RecipeServices recipeServices = RecipeServices();
  List<RecipeModel> recipes = [];
  List<RecipeModel> getAllRecipe = [];
  List<Comments> comments = [];
  bool isLodding = false;
  void getRecipes(String category) async {
    isLodding = true;
    notifyListeners();
    try {
      recipes = await recipeServices.getRecipes(category);
      log(recipes.toString());
      if (recipes.isEmpty) {
        log('No data');
      } else {
        log('Data found');
      }
    } catch (e) {
      log(e.toString());
    }finally{
    isLodding = false;
    notifyListeners();
    }

    notifyListeners();
  }
  void addData({required RecipeModel data})async{
    log('addingg......');
    try {
    recipeServices.addDAtaToFirebase(data);
    notifyListeners();
    }on FirebaseException catch (e) {
      log(e.toString());
    }
    getRecipes('');
  }

  void getComments({required String id})async{
     comments = await recipeServices.fetchComments(id);
     notifyListeners();
  }
  void addCommnet({
    required String id,
    required Comments data
  })async{
     try {
  recipeServices.addComments(data);
  getComments(id: id);
} on Exception catch (e) {
   log(e.toString());
}
  }

  void getAllDAta()async{
   getAllRecipe = await recipeServices.getAllRecipes();
   notifyListeners();
  }
}

