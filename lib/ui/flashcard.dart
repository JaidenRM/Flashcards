import 'package:flashcards/bloc/event/flashcard_event.dart';
import 'package:flashcards/bloc/event/man_fc_event.dart';
import 'package:flashcards/bloc/man_fc_bloc.dart';
import 'package:flashcards/bloc/state/man_fc_state.dart';
import 'package:flashcards/model/flashcard_model.dart';
import 'package:flashcards/service/repository.dart';
import '../bloc/flashcard_bloc.dart';
import '../bloc/state/flashcard_state.dart';
import '../constants.dart';
import '../styles/app_styles.dart';
import '../widget/appbar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Flashcard extends StatefulWidget {
  
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  static final _repo = Repository();
  final _bloc = FlashcardBloc();
  final _manageBloc = ManageFlashcardBloc(repo: _repo);

  @override
  Widget build(BuildContext context) {
    _manageBloc.onFetch();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => _bloc),
        BlocProvider(create: (BuildContext context) => _manageBloc)
      ], 
      child: BlocListener<ManageFlashcardBloc, ManageFlashcardState>(
        listener: (context, state) => {
          //on every 3rd tap it likes but 1st tap to unlike
          if(state is UpdatingStatsState) {
            Future.delayed(Duration(seconds: 1), () => _manageBloc.onFetch())
          }
        },
        child: FlashcardWidget()
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _manageBloc.close();
  }
}

class FlashcardWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final _manFcBloc = context.bloc<ManageFlashcardBloc>();
    final _fcBloc = context.bloc<FlashcardBloc>();
    //final FlashcardModel flashcard;
    //BlocProvider.of<ManageFlashcardBloc>(context).add(FetchFlashcardEvent());
    return BlocBuilder<ManageFlashcardBloc, ManageFlashcardState>(
      builder: (context, state) {
        if(state is FetchingFlashcardsState
          || state is UpdatingStatsState
          || state is UpdatedStatsState)
            return Center(child: CircularProgressIndicator());
        else if(state is FetchedFlashcardsState) {
          return BlocBuilder<FlashcardBloc, FlashcardState>(
            builder: (context, state) {
              if(_fcBloc.state.isFront) {
                return GestureDetector(
                  onTap: () => _fcBloc.flip(),
                  child: FlashcardFrontWidget(
                    flashcards: (_manFcBloc.state as FetchedFlashcardsState).flashcards
                  )
                );
              } else {
                return GestureDetector(
                  onTap: () => _fcBloc.flip(),
                  child: FlashcardBackWidget(
                    flashcards: (_manFcBloc.state as FetchedFlashcardsState).flashcards
                  )
                );
              }
            },
          );
        } else {
          return Text("We are not fetching...");
        }
      },
    );
  }
  
}

class FlashcardFrontWidget extends StatelessWidget {
  final List<FlashcardModel> flashcards;
  final fcIndex = 0;

  FlashcardFrontWidget({ @required this.flashcards });

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
                    flashcards[fcIndex].question, 
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
                    Tooltip(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.all(10),
                      decoration: AppDeco.BLACK_BOX,
                      textStyle: AppText.TOOLTIP_TEXT,
                      message: flashcards[fcIndex].hint,
                      child: Icon(Icons.help_outline, size: 75, color: TERTIARY_COL)
                    )
                  ],
                ),
              )
            ],
          )
        )
    );
  }
}
class FlashcardBackWidget extends StatelessWidget {
  final List<FlashcardModel> flashcards;
  final fcIndex = 0;

  FlashcardBackWidget({ @required this.flashcards });
  
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
                    flashcards[fcIndex].answer, 
                    style: AppText.MAX_TEXT,
                    minFontSize: 18
                  ),
                )  
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: BlocBuilder<ManageFlashcardBloc, ManageFlashcardState>(
                  builder: (context, state) {
                    final _bloc = context.bloc<ManageFlashcardBloc>();
                    return (
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => {
                              _bloc.onUpdate(isRight: true),
                              //_bloc.onFetch()
                            },
                            child: Icon(Icons.check, size: 75, color: POS_COL)
                          ),
                          GestureDetector(
                            onTap: () => {
                              _bloc.onUpdate(isWrong: true),
                              //_bloc.onFetch()
                            },
                            child: Icon(Icons.clear, size: 75, color: NEG_COL)
                          ),
                          GestureDetector(
                            onTap: () => {
                              _bloc.onUpdate(isLiked: true),
                              //_bloc.onFetch()
                            },
                            child: Icon(flashcards[fcIndex].isLiked ?
                              Icons.favorite : Icons.favorite_border
                              , size: 60, color: NEG_COL)
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