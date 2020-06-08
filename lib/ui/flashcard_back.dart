import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flashcards/bloc/man_fc_bloc.dart';
import 'package:flashcards/bloc/state/update_fc_state.dart';
import 'package:flashcards/bloc/update_fc_bloc.dart';
import 'package:flashcards/model/flashcard_model.dart';
import 'package:flashcards/styles/app_styles.dart';
import 'package:flashcards/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';

class FlashcardBackWidget extends StatefulWidget {
  final FlashcardModel flashcard;
  final Key key;

  FlashcardBackWidget(this.flashcard, this.key) : super(key: key);

  @override
  FlashcardBackWidgetState createState() => FlashcardBackWidgetState(flashcard);

}

class FlashcardBackWidgetState extends State<FlashcardBackWidget> with SingleTickerProviderStateMixin {
  final FlashcardModel flashcard;
  AnimationController _animController;
  Animation _anim;

  FlashcardBackWidgetState(this.flashcard);
  
  void exit() {
    setState(() {
      _animController.forward(from: 0.0);
    });
  }

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _anim = Tween<double>(begin: 0, end: 1 * pi).animate(_animController);

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
                    flashcard.answer, 
                    style: AppText.MAX_TEXT,
                    minFontSize: 18
                  ),
                )  
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: BlocBuilder<UpdateFlashcardBloc, UpdateFlashcardState>(
                  builder: (context, state) {
                    return (
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => context.bloc<ManageFlashcardBloc>().onChangeCard(false),
                            child: Icon(
                              Icons.keyboard_arrow_left
                              , size: 75
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onRight(flashcard.id),
                            },
                            child: Icon(Icons.check, size: 75, color: POS_COL)
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onWrong(flashcard.id),
                            },
                            child: Icon(Icons.clear, size: 75, color: NEG_COL)
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onLiked(flashcard.id),
                            },
                            child: Icon(flashcard.isLiked ?
                              Icons.favorite : Icons.favorite_border
                              , size: 60, color: NEG_COL)
                          ),
                          GestureDetector(
                            onTap: () => context.bloc<ManageFlashcardBloc>().onChangeCard(true),
                            child: Icon(
                              Icons.keyboard_arrow_right
                              , size: 75
                            ),
                          ),
                        ],
                      )
                    );
                  },
                ),
              )
            ],
          )
        )
    );
  }
}