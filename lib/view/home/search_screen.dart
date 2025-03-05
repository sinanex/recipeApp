import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';
import 'package:recipieapp/controller/recipe_controller.dart';
import 'package:recipieapp/view/viewpage/details_screen.dart';
import 'package:recipieapp/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeController>(context, listen: false).getRecipes('All');
      Provider.of<AuthController>(context, listen: false).getUserData();
      Provider.of<RecipeController>(context, listen: false).getAllDAta();
    });
  }

  @override
  Widget build(BuildContext context) {
    return context.read<RecipeController>().isLodding
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
          backgroundColor: Color(0XFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Find best recipes\nfor cooking',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                customTextfeild(_searchController, 'search'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending Now 🔥 ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('View More'),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: Consumer<RecipeController>(
                    builder:
                        (context, value, child) => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: value.getAllRecipe.length,
                          itemBuilder: (context, index) {
                            final data = value.getAllRecipe[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              DetailsScreen(recipe: data),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.grey.shade300,
                                        offset: Offset(3, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        height: 150,
                                        child: CachedNetworkImage(
                                          imageUrl: value.getAllRecipe[index].image,
                                          placeholder:
                                              (context, url) =>
                                                  Center(child: CircularProgressIndicator()),
                                          errorWidget:
                                              (context, url, error) =>
                                                  Icon(Icons.error),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            value.getAllRecipe[index].name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.schedule,
                                                size: 18,
                                                color: Colors.grey,
                                              ), // Time icon
                                              const SizedBox(width: 4),
                                              Text(
                                                '${value.getAllRecipe[index].time} min',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 15,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<RecipeController>().getRecipes(
                       'ALL',
                          );
                        },
                        child: Text('ALL'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<RecipeController>().getRecipes(
                      'Desserts',
                          );
                        },
                        child: Text('Desserts'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<RecipeController>().getRecipes(
                      'Appetizers',
                          );
                        },
                        child: Text('Appetizers'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<RecipeController>().getRecipes(
                           'Main Courses',
                          );
                        },
                        child: Text('Main Courses'),
                      ),
                    ],
                  ),
                ),
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
                        (context, value, child) =>  value.recipes.isEmpty? Center(child: Text('no data'),): ListView.builder(
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
                              child: Card(
                                elevation: 1,
                                color: Colors.white,
                                child: Container(
                                  width: double.infinity,
                                  height: 100,
                                  margin: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Hero(
                                        tag: recipe.image,
                                  child:     CachedNetworkImage(
                                          imageUrl: value.recipes[index].image,
                                          placeholder:
                                              (context, url) =>
                                                  Center(child: CircularProgressIndicator()),
                                          errorWidget:
                                              (context, url, error) =>
                                                  Icon(Icons.error),
                                        ),
                                      ),
                                      Column(
                                        spacing: 20,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            value.recipes[index].name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            value.recipes[index].description,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                ),
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
