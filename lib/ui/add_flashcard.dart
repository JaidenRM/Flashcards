import 'package:flashcards/bloc/add_fc_bloc.dart';
import 'package:flashcards/bloc/state/add_fc_state.dart';
import 'package:flashcards/service/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFlashcard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddState();
}

class _AddState extends State<AddFlashcard> {
  static final Repository _repo = Repository();
  final _bloc = AddFlashcardBloc(repo: _repo);

  String question, answer, hint;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add flashcard')),
      body: BlocProvider(
        create: (context) => _bloc,
        child: BlocListener<AddFlashcardBloc, AddFlashcardState>(
          listener: (context, state) {
            if(state is AddedState && state.isSucc)
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text("Success!"),
                  content: Text('You\'ve successfully added a new flashcard.'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                      child: Text('Back'),
                      onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                    ),
                  ],
                )
              );
          },
          child: BlocBuilder<AddFlashcardBloc, AddFlashcardState>(
            builder: (context, state) 
            {
              return Column(
                children: <Widget>[
                  Row(children: <Widget> [
                    Text('Question*'),
                    Expanded(
                      child: TextField(
                        onChanged: (text) => question = text,
                    )),
                    if(state is ErrorState && state.question != Validator.SUCCESS)
                      Text(_errorText(state.question))
                  ]),
                  Row(children: <Widget> [
                    Text('Answer*'),
                    Expanded(
                      child: TextField(
                        onChanged: (text) => answer = text,
                    )),
                    if(state is ErrorState && state.answer != Validator.SUCCESS)
                      Text(_errorText(state.answer))
                  ]),
                  Row(children: <Widget> [
                    Text('Hint'),
                    Expanded(
                      child: TextField(
                        onChanged: (text) => hint = text
                    )),
                    if(state is ErrorState && state.hint != Validator.SUCCESS)
                      Text(_errorText(state.hint))
                  ]),
                  RaisedButton(
                    onPressed: () => _bloc.onAdd(question, answer, hint),
                    child: Text('Submit'),
                  )
                ]
              );
            }
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}

String _errorText(Validator error) {
  switch(error) {
    case Validator.EMPTY:
      return "Please enter a value";
    case Validator.INVALID:
      return "Sorry, that value is not valid";
    default:
      return "Unknown error!";
  }
}