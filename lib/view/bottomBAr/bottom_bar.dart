import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/bottom_bar.dart';
import 'package:recipieapp/view/favorite/favorite_screen.dart';
import 'package:recipieapp/view/add/add_screen.dart';
import 'package:recipieapp/view/home/search_screen.dart';
import 'package:recipieapp/view/profile/profile_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: Provider.of<BottomBarProvider>(context).currentIndex,
        children: [ SearchScreen(), AddScreen(), FavoriteScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        currentIndex: Provider.of<BottomBarProvider>(context).currentIndex,
        onTap:
            (value) => Provider.of<BottomBarProvider>(
              context,
              listen: false,
            ).updateIndex(value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
