import 'package:flashcards/constants.dart';
import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/widget/menu_drag_scroll.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(widget.title)),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Image.asset(IMG_LOGO),
            Container(
              child: DraggableScrollableMenu()
            )
          ],
        )
      ),
    );
  }

}
