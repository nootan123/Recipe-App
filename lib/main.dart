import 'package:Recipe/screens/home.dart';
import 'package:Recipe/screens/listItem.dart';
import 'package:Recipe/screens/listItemAll.dart';
import 'package:Recipe/screens/recipe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          // textTheme: TextTheme(color: Colors.white, fontSize: 18,),
        ),
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        themeMode: ThemeMode.system,
        routes: {
          '/': (contex) => Home(),
          '/recipe': (context) => Recipe(),
          '/listItem': (context) => ListItm(),
          '/list': (context) => ListItmAll()
        },
      ),
    );
  });
}
