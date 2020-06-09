import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/utils/routes.dart';
import 'package:flutter/material.dart';
import 'custom_clippers.dart';

class DraggableScrollableMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.125,
      minChildSize: 0.125,
      maxChildSize: 0.8,
      builder: (context, scrollCtrl) {
        return TopCurveClipShadow(
          shadow: Shadow(blurRadius: 30, offset: Offset(1.0, 1.0), color: Colors.black), 
          clipper: TopCurveClipper(), 
          child: Container(
            color: Colors.white,
            child: ListView(
              controller: scrollCtrl,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 50),),
                Text('Scroll Up!', style: AppText.LABEL_TEXT, textAlign: TextAlign.center,),
                Padding(padding: EdgeInsets.only(top: 70),),
                FetchRoute(),
                Padding(padding: EdgeInsets.all(30),),
                AddRoute()
              ]
            )
          ),
        );
      },
    );
  }
}