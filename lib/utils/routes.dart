import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/ui/add_flashcard.dart';
import 'package:flashcards/ui/animations/route_anim.dart';
import 'package:flashcards/ui/flashcard.dart';
import 'package:flutter/material.dart';

class FetchRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:GestureDetector(
        onTap: () => {
          Navigator.of(context).push( 
            createRouteAnim(Flashcard())
          )
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          decoration: AppDeco.BOX_BORDER_SHADOW,
          child: Text("Start"),
        )
      )
    );
  }
}

class AddRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:GestureDetector(
        onTap: () => {
          Navigator.of(context).push( 
            createRouteAnim(AddFlashcard())
          )
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
          decoration: AppDeco.BOX_BORDER_SHADOW,
          child: Text("Add Flashcard"),
        )
      )
    );
  }
}
