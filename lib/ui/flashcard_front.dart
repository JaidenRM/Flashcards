import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcards/bloc/man_fc_bloc.dart';
import 'package:flashcards/model/flashcard_model.dart';
import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class FlashcardFrontWidget extends StatefulWidget {
  final FlashcardModel flashcard;
  final Key key;

  FlashcardFrontWidget(this.flashcard, this.key ) : super(key: key);

  @override
  FlashcardFrontWidgetState createState() => FlashcardFrontWidgetState(flashcard);
}

class FlashcardFrontWidgetState extends State<FlashcardFrontWidget> with SingleTickerProviderStateMixin {
  final FlashcardModel flashcard;
  AnimationController _animController;
  Animation _anim;

  FlashcardFrontWidgetState(this.flashcard);
  
  void exit() {
    setState(() {
      _animController.forward(from: 0.0);
    });
  }

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _anim = Tween<double>(begin: 0, end: -1 * pi).animate(_animController);

    _animController.addListener(() => setState(() {}));

    _animController.reverse(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('Flashcard'),
      body: 
        Container(
          transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) //These are magic numbers, just use them :)
              ..rotateX(_anim.value),
          margin: EdgeInsets.all(20),
          decoration: AppDeco.BOX_BORDER_SHADOW,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    flashcard.question, 
                    style: AppText.MAX_TEXT,
                    minFontSize: 18
                  )
                )  
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => context.bloc<ManageFlashcardBloc>().onChangeCard(false),
                      child: Icon(
                        Icons.keyboard_arrow_left
                        , size: 75
                      ),
                    ),
                    Tooltip(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.all(10),
                      decoration: AppDeco.BLACK_BOX,
                      textStyle: AppText.TOOLTIP_TEXT,
                      message: flashcard.hint,
                      child: Icon(Icons.help_outline, size: 75, color: TERTIARY_COL)
                    ),
                    GestureDetector(
                      onTap: () => context.bloc<ManageFlashcardBloc>().onChangeCard(true),
                      child: Icon(
                        Icons.keyboard_arrow_right
                        , size: 75
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        )
    );
  }
}