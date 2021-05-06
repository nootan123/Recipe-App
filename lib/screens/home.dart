import 'package:Recipe/widgets/scrollableCard.dart';
import 'package:Recipe/widgets/singleCard.dart';
import 'package:Recipe/widgets/singleCardAll.dart';
import 'package:flutter/material.dart';
import '../widgets/searchDel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search1(),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
              child: Column(
                children: <Widget>[
                  singleCardAll(
                    "lib/assets/food2.jpg",
                    "All Recipes",
                    Alignment.centerLeft,
                    context,
                  ),
                  scrollCard(
                    "Recipes you Might like...",
                    "Recipe recommendations for you",
                    "lib/assets/food1.jpg",
                    context,
                  ),
                  singleCard("lib/assets/americanFood.jpg", "American Recipies",
                      Alignment.center, context, 'USA'),
                  singleCard("lib/assets/africanFood.jpg", "African Recipies",
                      Alignment.center, context, 'Africa'),
                  singleCard("lib/assets/asianFood.jpg", "Asian Recipies",
                      Alignment.center, context, 'Nepal'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
