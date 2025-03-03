import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: (){}, child: Text('')),
              ElevatedButton(onPressed: (){}, child: Text('')),
              ElevatedButton(onPressed: (){}, child: Text('')),
            ],
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Popular Searches'),
               Text('View More')
             ],
           ),

           SizedBox(
            height: 200,
             child: Expanded(child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: 10,
               itemBuilder: (context, index) {
               
               return Container(
                 width: 150,
                 color: Colors.red,
                 margin: EdgeInsets.all(8.0),
               );
             },)),
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('ediors choice'),
               Text('View More'),
             ],
           ),
            Expanded(child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
              
              return Container(
                width: double.infinity,
                height: 200,
            
                color: Colors.red,
                margin: EdgeInsets.all(8.0),
              );
            },)),

          ],
        ),
      ),
    );
  }
}