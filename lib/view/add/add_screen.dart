import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';
import 'package:recipieapp/controller/dropdown.dart';
import 'package:recipieapp/controller/img_controller.dart';
import 'package:recipieapp/controller/recipe_controller.dart';
import 'package:recipieapp/controller/textfeild_controller.dart';
import 'package:recipieapp/model/recipe_model.dart';
import 'package:recipieapp/widgets/widgets.dart';

class AddScreen extends StatelessWidget {
  TextEditingController _stepsController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Recipe')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    log('upload images.........');
                    context.read<ImgProviderController>().uploadImage();
                  },
                  child: Consumer<ImgProviderController>(
                    builder:
                        (context, value, child) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            image: DecorationImage(
                              image:
                                  value.selectedImge != null
                                      ? FileImage(
                                        File(value.selectedImge!.path),
                                      )
                                      : NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQOlSVR1x_LByeD7pH6M8086NwgI6yaI8ZBIg&s',
                                      ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: double.infinity,
                          height: 200,
                        ),
                  ),
                ),
              ),
              customTextfeild(_titleController, 'Title'),
              customTextfeild(_descriptionController, 'Description'),
              customTextfeild(_timeController, 'Cooking Time'),
              Consumer<DropdownProvider>(
                builder:
                    (context, value, child) => DropdownButton<String>(
                      value: value.selectedValue,
                      hint: Text("Select an item"),
                      items:
                          value.items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        value.setSelectedValue(newValue);
                      },
                    ),
              ),
              customTextfeild(_stepsController, 'Instructions'),

              Text('incredians'),
              Consumer<TextfeildController>(
                builder:
                    (context, value, child) => ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.textFields.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: customTextfeild(
                                  value.controllers[index],
                                  'Ingredient',
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: customTextfeild(
                                  value.Qtycontrollers[index],
                                  'Qty',
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  value.removeTextfeild(index);
                                },
                                icon: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              ),

              ElevatedButton(
                onPressed: () {
                  context.read<TextfeildController>().addTextfeild();
                },
                child: Text("Add New Incrediant"),
              ),
              ElevatedButton(
                onPressed: () {
                  getIngredientsMap(context);
                  addDAtaToFirebase(context);
                },
                child: Text("Add Recipe"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, String> getIngredientsMap(BuildContext context) {
    Map<String, String> ingredientsMap = {};
    for (
      int i = 0;
      i < context.read<TextfeildController>().controllers.length;
      i++
    ) {
      String ingredient =
          context.read<TextfeildController>().controllers[i].text.trim();
      String quantity =
          context.read<TextfeildController>().Qtycontrollers[i].text.trim();
      if (ingredient.isNotEmpty && quantity.isNotEmpty) {
        ingredientsMap[ingredient] = quantity;
      }
    }
    log(ingredientsMap.toString());
    return ingredientsMap;
  }

  void addDAtaToFirebase(BuildContext context) {
    if (_descriptionController.text.isEmpty ||
        _stepsController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _titleController.text.isEmpty ||
        context.read<ImgProviderController>().selectedImge == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('fill All feild')));
    } else {
      final data = RecipeModel(
        catogary: context.read<DropdownProvider>().selectedValue ?? '',
        username: context.read<AuthController>().username ?? '',
        ingredients: getIngredientsMap(context),
        name: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        time: _timeController.text.trim(),
        steps: _stepsController.text.trim(),
        image: context.read<ImgProviderController>().imgUrl ?? '',
      );
      context.read<RecipeController>().addData(data: data);
      log(data.toString());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Recipe Added')));
    }
  }
}
