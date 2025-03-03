import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/auth_controller.dart';
import 'package:recipieapp/controller/bottom_bar.dart';
import 'package:recipieapp/controller/img_controller.dart';
import 'package:recipieapp/controller/recipe_controller.dart';
import 'package:recipieapp/view/bottomBAr/bottom_bar.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => RecipeController()),
        ChangeNotifierProvider(create: (context) => BottomBarProvider()),
        ChangeNotifierProvider(create: (context) => ImgController()),
      ],
      child: BottomBar()),
    );
  }

}
