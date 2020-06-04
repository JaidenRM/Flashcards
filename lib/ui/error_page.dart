import 'package:flashcards/styles/app_styles.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Oops!', style: TextStyle(fontSize: 80, color: Colors.red),),
                      Text('An error has occured!', 
                        style: AppText.ERROR_TEXT,
                        textAlign: TextAlign.center)
                    ],))),
              Container(
                margin: EdgeInsets.only(bottom: 100),
                child: RaisedButton(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst), 
                  child: Text('Go home', style: AppText.LABEL_TEXT,)))
            ],
          ),
        )
      )
    );
  }
}