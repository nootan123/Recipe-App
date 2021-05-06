import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Search1 extends SearchDelegate<String> {
  String result;
  int a = 0;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('recipe').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Text('Search');
        else
          return SizedBox(
            height: 800,
            child: ListView.builder(
              itemCount: snapshot.data.docs[0]['recipeDoc'].length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data.docs[0]['recipeDoc'][index]['name']
                        .toLowerCase()
                        .contains(query.toLowerCase()) &&
                    query != '') {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Card(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Hero(
                              tag: snapshot.data.docs[0]['recipeDoc'][index]
                                  ['img'],
                              child: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    snapshot.data.docs[0]['recipeDoc'][index]
                                        ['img']),
                                radius: 30,
                              ),
                            ),
                            title: Center(
                              child: Text(
                                snapshot.data.docs[0]['recipeDoc'][index]
                                    ['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/recipe',
                            arguments: {
                              'index': index,
                              'img': snapshot.data.docs[0]['recipeDoc'][index]
                                  ['img'],
                              'name': snapshot.data.docs[0]['recipeDoc'][index]
                                  ['name']
                            },
                          );
                        },
                      ),
                      elevation: 5,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('recipe').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Text('Search');
        else
          return ListView.builder(
            itemCount: snapshot.data.docs[0]['recipeDoc'].length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.data.docs[0]['recipeDoc'][index]['name']
                  .toLowerCase()
                  .contains(query.toLowerCase())) {
                return ListTile(
                  title:
                      Text(snapshot.data.docs[0]['recipeDoc'][index]['name']),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/recipe',
                      arguments: {
                        'index': index,
                        'name': snapshot.data.docs[0]['recipeDoc'][index]
                            ['name']
                      },
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          );
      },
    );
  }
}
