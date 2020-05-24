import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/utils/routes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String title;
  
  Home({this.title});
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FetchRoute(),
            AddRoute()
          ],)
      ),
    );
  }

}
