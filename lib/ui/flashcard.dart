import 'package:flashcards/bloc/man_fc_bloc.dart';
import 'package:flashcards/bloc/state/man_fc_state.dart' as manState;
import 'package:flashcards/bloc/state/update_fc_state.dart';
import 'package:flashcards/bloc/update_fc_bloc.dart';
import 'package:flashcards/service/repository.dart';
import 'package:flashcards/ui/error_page.dart';
import '../bloc/flashcard_bloc.dart';
import '../bloc/state/flashcard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'empty_page.dart';
import 'flashcard_back.dart';
import 'flashcard_front.dart';

class Flashcard extends StatefulWidget {
  
  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  static final _repo = Repository();
  static final _bloc = FlashcardBloc();
  static final _updateBloc = UpdateFlashcardBloc(_repo);
  static final _manageBloc = ManageFlashcardBloc(_repo, _updateBloc);

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => _bloc),
        BlocProvider(create: (BuildContext context) => _manageBloc),
        BlocProvider(create: (BuildContext context) => _updateBloc)
      ], 
      child: BlocListener<UpdateFlashcardBloc, UpdateFlashcardState>(
        listener: (context, state) => {
          if(state is UpdatingFlashcardState) {
            Future.delayed(Duration(seconds: 1), () => Center(child: CircularProgressIndicator()))
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
    _updateBloc.close();
  }
}

class FlashcardWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageFlashcardBloc, manState.ManageFlashcardState>(
      builder: (context, state) {
        if(state is manState.UninitialisedState) {
          context.bloc<ManageFlashcardBloc>().onFetch();
        }   

        if(state is manState.FetchingFlashcardsState)
            return Center(child: CircularProgressIndicator());
        else if(state is manState.FetchedFlashcardsState) {
          return BuildFlashcard();
        } else if(state is manState.EmptyState) {
          return EmptyPage();
        } else if(state is manState.ErrorState) {
          return ErrorPage();
        }else {
          return Text("We are not fetching...");
        }
      },
    );
  } 
}

class BuildFlashcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlashcardBloc, FlashcardState>(
      builder: (context, state) {
        final _manState = context.bloc<ManageFlashcardBloc>().state as manState.FetchedFlashcardsState;
        if(context.bloc<FlashcardBloc>().state.isFront) {
          return GestureDetector(
            onTap: () => context.bloc<FlashcardBloc>().flip(),
            child: FlashcardFrontWidget(
              flashcard: _manState.flashcards[_manState.currId]
            )
          );
        } else {
          return GestureDetector(
            onTap: () => context.bloc<FlashcardBloc>().flip(),
            child: FlashcardBackWidget(
              flashcard: _manState.flashcards[_manState.currId]
            )
          );
        }
      },
    );
  }

}