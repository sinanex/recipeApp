import 'package:flutter/material.dart';
import 'package:recipieapp/model/recipe_model.dart';
import 'package:recipieapp/view/viewpage/tabBar/ingredians.dart';
import 'package:recipieapp/view/viewpage/tabBar/steps.dart';

class DetailsScreen extends StatelessWidget {
  final RecipeModel recipe;
  DetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            Hero(
              tag: recipe.image,
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(recipe.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 100,
                          height: 10,
                        ),
                      ),
              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipe.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 18),
                              SizedBox(width: 5),
                              Text('${recipe.time} min'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        recipe.description,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 8),
              
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(Icons.star, color: Colors.amber),
                        ),
                      ),
                      SizedBox(height: 10),
                      TabBar(
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(icon: Icon(Icons.restaurant), text: 'Ingredients'),
                          Tab(icon: Icon(Icons.list), text: 'Steps'),
                        ],
                      ),
              
                      Expanded(
                        child: TabBarView(
                          children: [
                            IngredientsPage(ingredients: recipe.ingredients),
                            StepsScreen(steps: recipe.steps),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
