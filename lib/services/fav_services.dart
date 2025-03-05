import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipieapp/model/recipe_model.dart';

class FavoriteService {
  final firestore = FirebaseFirestore.instance.collection('favorites');

  void addFav(RecipeModel data) async {
    final User? user = FirebaseAuth.instance.currentUser;
    try {
      await firestore
          .doc(user?.uid)
          .collection('favItems')
          .doc(data.id)
          .set(data.toJson());
    } catch (e) {
      log(e.toString());
    }
      getFav();
  }

  Future<List<RecipeModel>> getFav() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await firestore.doc(user.uid).collection('favItems').get();
      return response.docs
          .map((doc) => RecipeModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      log("Error fetching favorites: $e");
      return [];
    }
  }
  Future<void> removeFav(String recipeId) async {
  final User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try {
    await firestore
        .doc(user.uid)
        .collection('favItems')
        .doc(recipeId) 
        .delete();

    log("Favorite removed successfully!");
  } catch (e) {
    log("Error removing favorite: $e");
  }
  getFav();
}

}
