import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/recipe_controller.dart';
import 'package:recipieapp/view/viewpage/details_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RecipeController>(context, listen: false).getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Screen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 10),

            // Row with buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Button 1')),
                ElevatedButton(onPressed: () {}, child: Text('Button 2')),
                ElevatedButton(onPressed: () {}, child: Text('Button 3')),
              ],
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Searches',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('View More', style: TextStyle(color: Colors.blue)),
              ],
            ),
            SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: Consumer<RecipeController>(
                builder:
                    (context, value, child) => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.recipes.length,
                      itemBuilder: (context, index) {
                        int reversedIndex = value.recipes.length - 1 - index;
                        return Container(
                          child: Image.network(
                            value.recipes[reversedIndex].image,
                          ),
                          width: 150,
                          margin: EdgeInsets.all(8.0),
                        );
                      },
                    ),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Editor\'s Choice',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('View More', style: TextStyle(color: Colors.blue)),
              ],
            ),
            SizedBox(height: 10),

            Expanded(
              child: Consumer<RecipeController>(
                builder:
                    (context, value, child) => ListView.builder(
                      itemCount: value.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = value.recipes[index];
                        return GestureDetector(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          DetailsScreen(recipe: recipe),
                                ),
                              ),
                          child: Container(
                            child: Column(
                              children: [
                                Hero(
                                  tag: recipe.image,
                                  child: Image.network(
                                    value.recipes[index].image,
                                    width: 100,
                                  ),
                                ),
                                Text(value.recipes[index].name),
                                Text(value.recipes[index].description),
                              ],
                            ),
                            width: double.infinity,
                            height: 150,
                            color: Colors.blue,
                            margin: EdgeInsets.all(8.0),
                          ),
                        );
                      },
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
