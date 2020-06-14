import 'package:flashcards/ui/home.dart';
import './constants.dart';
import './ui/flashcard.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(primaryColor: PRIMARY_COL),
      home: Home(title: "Home")
    );
  }
}