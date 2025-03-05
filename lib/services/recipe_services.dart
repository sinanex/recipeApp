import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipieapp/model/comments.dart';
import 'package:recipieapp/model/recipe_model.dart';

class RecipeServices {
  final fireStore = FirebaseFirestore.instance.collection('recipe');
  Future<List<RecipeModel>> getRecipes(String? catogary) async {
    QuerySnapshot filter;
    catogary ??= 'All';
    try {
      switch (catogary) {
        case 'Appetizers':
          filter = await fireStore.where('catogary', isEqualTo: catogary).get();

          break;
        case 'Main Courses':
          filter = await fireStore.where('catogary', isEqualTo: catogary).get();
          break;
        case 'Desserts':
          filter = await fireStore.where('catogary', isEqualTo: catogary).get();
          break;
        default:
          filter = await fireStore.get();
      }

      log('message$filter');
      return filter.docs
          .map(
            (docs) => RecipeModel.fromJson(
              docs.data() as Map<String, dynamic>,
              docs.id,
            ),
          )
          .toList();
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  void addDAtaToFirebase(RecipeModel data) async {
    try {
      final response = await fireStore.add(data.toJson());
      log(response.id);
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }

  Future<List<RecipeModel>> getAllRecipes() async {
    log('message');
    try {
      QuerySnapshot response = await fireStore.get();
      for (var element in response.docs) {
        log(element['ing'].toString());
      }
      return response.docs
          .map(
            (e) => RecipeModel.fromJson(e.data() as Map<String, dynamic>, e.id),
          )
          .toList();
    } on FirebaseException catch (e) {
      log(e.toString());
      throw Exception(e.message);
    }
  }

  Future<List<Comments>> fetchComments(String recipeId) async {
    final comments = FirebaseFirestore.instance.collection('comments');
    try {
      QuerySnapshot response =
          await comments.where('id', isEqualTo: recipeId).get();
      return response.docs
          .map((e) => Comments.fromJson(e.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {}
    return [];
  }

  void addComments(Comments data) async {
    final comments = FirebaseFirestore.instance.collection('comments');
    try {
      comments.add(data.toJson());
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
