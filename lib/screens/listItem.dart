import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ListItm extends StatefulWidget {
  @override
  _ListItmState createState() => _ListItmState();
}

class _ListItmState extends State<ListItm> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> receiveData =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(receiveData['topic']),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('recipe').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return SpinKitFadingFour(
                color: Colors.blue,
                size: 50.0,
              );
            else
              return ListView.builder(
                itemCount: snapshot.data.docs[0]['recipeDoc'].length,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data.docs[0]['recipeDoc'][index]['country'] ==
                      receiveData['query']) {
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
                                'name': snapshot.data.docs[0]['recipeDoc']
                                    [index]['name']
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
              );
          },
        ),
      ),
    );
  }
}
