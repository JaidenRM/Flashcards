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
  Animation _growShrink;
  Animation _rockSideToSide;
  Animation _glideOut; //make the number glide side2side and up
  Animation _fadeOut; //combine with above to fade out as gliding

  FlashcardBackWidgetState(this.flashcard);
  
  void exit() {
    setState(() {
      _animController.forward(from: 0.0);
    });
  }

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: 1900));
    _anim = Tween<double>(begin: 0, end: 1 * pi).animate(
      CurvedAnimation(
        parent: _animController, 
        curve: Interval(0.9, 1),
        reverseCurve: Interval(0.8, 1)));
    _growShrink = 
        TweenSequence([
          TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.5), weight: 1),
          TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.5), weight: 2),
          TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 1), weight: 5)
        ])
      .animate(CurvedAnimation(parent: _animController, curve: Interval(0.0, 0.8)));
    _rockSideToSide =
        TweenSequence([
          TweenSequenceItem(tween: Tween<double>(begin: 0, end: -0.25*pi), weight: 1),
          TweenSequenceItem(tween: Tween<double>(begin: -0.25*pi, end: 0.25*pi), weight: 1),
          TweenSequenceItem(tween: Tween<double>(begin: 0.25*pi, end: -0.25*pi), weight: 1),
          TweenSequenceItem(tween: Tween<double>(begin: -0.25*pi, end: 0), weight: 1),
        ])
      .animate(CurvedAnimation(parent: _animController, curve: Interval(0.3, 0.6)));
    _glideOut = Tween<double>(begin: 30, end: 0).animate(CurvedAnimation(
      parent: _animController,
      curve: Interval(0.2, 0.6)
    ));
    _fadeOut = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animController,
      curve: Interval(0.9, 1),
      reverseCurve: Interval(0, 0.2)
    ));

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
                            onTap: () {
                              context.bloc<UpdateFlashcardBloc>().onRight(flashcard.id);
                            },
                            child: Stack(children: <Widget>[
                              Transform.rotate(
                                angle: state is UpdatedFlashcardState && state.updatedRight ? _rockSideToSide.value : 0,
                                child: Icon(Icons.check, color: POS_COL,
                                  size: state is UpdatedFlashcardState && state.updatedRight ? 75 * _growShrink.value : 75)
                              ), 
                              if(state is UpdatedFlashcardState && state.updatedRight)
                                Transform.translate(
                                  offset: Offset(_glideOut.value, 25 -_glideOut.value),
                                  child: Opacity(
                                    opacity: _fadeOut.value,
                                    child: Container(
                                      decoration: AppDeco.CIRCLE_BOX,
                                      padding: EdgeInsets.all(5),
                                      child: Text(flashcard.right.toString(), style: AppText.LABEL_TEXT)),
                                  )
                                )
                              ]
                            )
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onWrong(flashcard.id),
                            },
                            child: Stack(children: <Widget>[
                              Transform.rotate(
                                angle: state is UpdatedFlashcardState && state.updatedWrong ? _rockSideToSide.value : 0,
                                child: Icon(Icons.clear, color: NEG_COL,
                                  size: state is UpdatedFlashcardState && state.updatedWrong ? 75 * _growShrink.value : 75)
                              ), 
                              if(state is UpdatedFlashcardState && state.updatedWrong)
                                Transform.translate(
                                  offset: Offset(_glideOut.value, 25 -_glideOut.value),
                                  child: Opacity(
                                    opacity: _fadeOut.value,
                                    child: Container(
                                      decoration: AppDeco.CIRCLE_BOX,
                                      padding: EdgeInsets.all(5),
                                      child: Text(flashcard.wrong.toString(), style: AppText.LABEL_TEXT)),
                                  )
                                )
                              ]
                            )
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onLiked(flashcard.id),
                            },
                            child: Transform.rotate(
                              angle: state is UpdatedFlashcardState && state.updatedLiked ? _rockSideToSide.value : 0,
                              child: Icon(flashcard.isLiked ?
                                Icons.favorite : Icons.favorite_border
                                , size: state is UpdatedFlashcardState && state.updatedLiked ? 60 * _growShrink.value : 60
                                , color: NEG_COL))
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