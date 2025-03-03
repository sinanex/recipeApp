import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipieapp/model/recipe_model.dart';

class RecipeServices {
  final fireStore = FirebaseFirestore.instance.collection('recipe');
  Future<List<RecipeModel>> getRecipes() async {
    log('message');
    try {
      QuerySnapshot response = await fireStore.get();
       for (var element in response.docs) {
        log(element['ing'].toString());
      }
      return response.docs
          .map((e) => RecipeModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } on FirebaseException catch (e) {
      log(e.toString());
      throw Exception(e.message);
    }
  }
}
