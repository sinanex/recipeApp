import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';
import 'package:recipieapp/controller/favorate_controller.dart';
import 'package:recipieapp/controller/recipe_controller.dart';
import 'package:recipieapp/model/comments.dart';
import 'package:recipieapp/model/recipe_model.dart';
import 'package:recipieapp/services/fav_services.dart';
import 'package:recipieapp/view/viewpage/tabBar/ingredians.dart';
import 'package:recipieapp/view/viewpage/tabBar/steps.dart';
import 'package:recipieapp/widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  final RecipeModel recipe;
  const DetailsScreen({super.key, required this.recipe});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController _comment = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<RecipeController>(
      context,
      listen: false,
    ).getComments(id: widget.recipe.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            // Recipe Image
            Hero(
              tag: widget.recipe.image,
              child: Stack(
                children:[
                   Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      image: NetworkImage(widget.recipe.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: IconButton(icon: Icon( Icons.arrow_back_ios,size: 40,),onPressed: () {
                          Navigator.pop(context);
                        },)),
          ]),
            ),

            // Expanded Content
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
                      // Handle Indicator
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

                      // Recipe Name & Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.recipe.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.schedule, size: 18),
                              SizedBox(width: 5),
                              Text('${widget.recipe.time} min'),
                              IconButton(onPressed: (){
                             context.read<FavorateController>().favButton(widget.recipe);
                                
                              }, icon: Icon(Icons.favorite,color: context.watch<FavorateController>().color,))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Recipe Description
                      Text(
                        widget.recipe.description,
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 8),

                      // Tabs for Ingredients & Steps
                      TabBar(
                        indicatorColor: Colors.black,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            icon: Icon(Icons.restaurant),
                            text: 'Ingredients',
                          ),
                          Tab(icon: Icon(Icons.list), text: 'Steps'),
                        ],
                      ),

                      // Using Expanded to prevent layout overflow
                      Expanded(
                        child: TabBarView(
                          children: [
                            IngredientsPage(
                              ingredients: widget.recipe.ingredients,
                            ),
                            StepsScreen(steps: widget.recipe.steps),
                          ],
                        ),
                      ),

                      Text(
                        "Comments",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: customTextfeild(_comment, 'add Comments'),
                          ),
                          IconButton(
                            onPressed: () {
                              addCommnt();
                            },
                            icon: Icon(Icons.check),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Consumer<RecipeController>(
                          builder:
                              (context, value, child) =>
                                  value.comments.isEmpty
                                      ? Center(child: Text('no commments available'))
                                      : ListView.builder(
                                        itemCount: value.comments.length,

                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                              backgroundColor: Colors.grey[300],
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      value
                                                          .comments[index]
                                                          .image,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              value.comments[index].name,
                                            ),
                                            subtitle: Text(
                                              value.comments[index].comment,
                                            ),
                                          );
                                        },
                                      ),
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

  void addCommnt() {
    try {
      if (_comment.text.isEmpty) {
        return;
      }
      final data = Comments(
        recipeid: widget.recipe.id,
        comment: _comment.text.trim(),
        image: context.read<AuthController>().image ?? '',
        name: context.read<AuthController>().username ?? '',
      );
      context.read<RecipeController>().addCommnet(
        id: widget.recipe.id ?? '',
        data: data,
      );
      _comment.clear();
    } catch (e) {
      log(e.toString());
    }
  }
}
