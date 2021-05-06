import 'package:flutter/material.dart';

Widget singleCard(
  String image,
  String topic,
  Alignment a,
  BuildContext context,
  String query,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
    child: Card(
      child: Material(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
        

          child: Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: a,
              child: Text(
                topic,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    letterSpacing: 3,
                    fontFamily: "Arial"),
              ),
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/listItem', arguments: {
              'topic': topic,
              'query': query,
            });
           
          
          },
        ),
      ),
      elevation: 10,
      shadowColor: Colors.deepOrange,
     
    ),
  );
}
