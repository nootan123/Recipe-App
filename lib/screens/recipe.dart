import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Recipe extends StatefulWidget {
  @override
  _RecipeState createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> receiveData =
        ModalRoute.of(context).settings.arguments;
    final int itemNumber = receiveData['index'];
    return Scaffold(
      appBar: AppBar(
        title: Text(receiveData['name']),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('recipe').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: SpinKitFadingFour(
                  color: Colors.blue,
                  size: 50.0,
                ),
              );
            return Column(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: FittedBox(
                      child: Hero(
                        tag: snapshot.data.docs[0]['recipeDoc']
                            [receiveData['index']]['img'],
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data.docs[0]['recipeDoc']
                              [receiveData['index']]['img'],
                          placeholder: (context, url) => Container(
                            height: 50,
                            width: 50,
                            child: SpinKitFadingFour(
                              color: Colors.blue,
                              size: 15.0,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      fit: BoxFit.fill),
                ),
                ListTile(
                  title: Text(snapshot.data.docs[0]['recipeDoc']
                      [receiveData['index']]['name']),
                  subtitle: Text(snapshot.data.docs[0]['recipeDoc']
                      [receiveData['index']]['time']),
                  onTap: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  tileColor: Colors.green.shade600,
                  leading: Icon(
                    Icons.dashboard_sharp,
                    size: 40,
                  ),
                  title: Text(
                    "Ingredients required",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalDivider(
                        endIndent: 8,
                        indent: 8,
                        width: 20,
                        color: Colors.black,
                      ),
                      Text(
                        'Count: ${snapshot.data.docs[0]['recipeDoc'][itemNumber]['ingredients'].length.toString()}',
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
                SizedBox(
                  height: snapshot
                          .data
                          .docs[0]['recipeDoc'][itemNumber]['ingredients']
                          .length
                          .toDouble() *
                      60,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data
                        .docs[0]['recipeDoc'][itemNumber]['ingredients'].length,
                    itemBuilder: (context, int index) {
                      return ListTile(
                        leading: Icon(Icons.food_bank),
                        title: Text(snapshot.data.docs[0]['recipeDoc']
                            [itemNumber]['ingredients'][index]),
                      );
                    },
                  ),
                ),
                ListTile(
                  tileColor: Colors.green.shade600,
                  leading: Icon(
                    Icons.directions,
                    size: 40,
                  ),
                  title: Text(
                    "Directions to Prepare ",
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {},
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Container(
                      child: Text(
                        snapshot
                            .data
                            .docs[0]['recipeDoc'][receiveData['index']]
                                ['description']
                            .replaceAll("\\n", "\n"),
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
