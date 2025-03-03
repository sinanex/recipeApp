import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipieapp/controller/bottom_bar.dart';
import 'package:recipieapp/view/add/add_screen.dart';
import 'package:recipieapp/view/home/home_screen.dart';
import 'package:recipieapp/view/home/search_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: Provider.of<BottomBarProvider>(context).currentIndex,
        children: [HomeScreen(), SearchScreen(),AddScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: Provider.of<BottomBarProvider>(context).currentIndex,
        onTap:
            (value) => Provider.of<BottomBarProvider>(
              context,
              listen: false,
            ).updateIndex(value),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
        ],
      ),
    );
  }
}
