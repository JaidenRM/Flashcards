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

class FlashcardBackWidget extends StatelessWidget {
  final FlashcardModel flashcard;

  FlashcardBackWidget({ @required this.flashcard });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('Flashcard'),
      body: 
        Container(
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
                    //final _bloc = ;
                    return (
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => { context.bloc<ManageFlashcardBloc>()
                              .onChangeCard()},
                            child: Icon(
                              Icons.keyboard_arrow_left
                              , size: 75
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onRight(flashcard.id),
                              //_bloc.onFetch()
                            },
                            child: Icon(Icons.check, size: 75, color: POS_COL)
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onWrong(flashcard.id),
                              //_bloc.onFetch()
                            },
                            child: Icon(Icons.clear, size: 75, color: NEG_COL)
                          ),
                          GestureDetector(
                            onTap: () => {
                              context.bloc<UpdateFlashcardBloc>().onLiked(flashcard.id),
                              //_bloc.onFetch()
                            },
                            child: Icon(flashcard.isLiked ?
                              Icons.favorite : Icons.favorite_border
                              , size: 60, color: NEG_COL)
                          ),
                          GestureDetector(
                            onTap: () => { context.bloc<ManageFlashcardBloc>()
                              .onFetch(
                                id: flashcard.id,
                                isNext: true)},
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