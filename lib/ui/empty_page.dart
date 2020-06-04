import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/utils/routes.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child:Text('No flashcards are currently saved...', 
                    style: AppText.HEADING_TEXT,
                    textAlign: TextAlign.center)))),
            Expanded(child: AddRoute())
          ],
        ),
      )
    );
  }

}