import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget scrollCard(String mainT, String subT, String img, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 10.0),
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 300,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(mainT),
              subtitle: Text(subT),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recipe')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return SpinKitFadingFour(
                        color: Colors.blue,
                        size: 50.0,
                      );
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.docs[0]['recipeDoc'].length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 150,

                                      child: Hero(
                                        tag: snapshot.data.docs[0]['recipeDoc']
                                            [index]['img'],
                                        child: FittedBox(
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot.data.docs[0]
                                                  ['recipeDoc'][index]['img'],
                                              placeholder: (context, url) =>
                                                  Container(
                                                height: 50,
                                                width: 50,
                                                child: SpinKitFadingFour(
                                                  color: Colors.blue,
                                                  size: 15.0,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            fit: BoxFit.fill),
                                      ),

                                      // borderRadius: BorderRadius.all(
                                      //   Radius.circular(8.0),
                                      // ),
                                    ),
                                    Container(
                                      width: 150,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.only(
                                            left: 0.0, right: 0.0),
                                        title: Text(
                                          snapshot.data.docs[0]['recipeDoc']
                                                  [index]['name'] ??
                                              '',
                                        ),
                                        subtitle: Text(
                                          snapshot.data.docs[0]['recipeDoc']
                                                  [index]['time'] ??
                                              '',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/recipe',
                                    arguments: {
                                      'index': index,
                                      'name': snapshot.data.docs[0]['recipeDoc']
                                          [index]['name']
                                    });
                              },
                            ),
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
      elevation: 5,
      shadowColor: Colors.greenAccent,
    ),
  );
}
