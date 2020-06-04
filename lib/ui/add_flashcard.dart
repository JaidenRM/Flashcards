import 'package:flashcards/bloc/add_fc_bloc.dart';
import 'package:flashcards/bloc/state/add_fc_state.dart';
import 'package:flashcards/service/repository.dart';
import 'package:flashcards/styles/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFlashcard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddState();
}

class _AddState extends State<AddFlashcard> {
  static final Repository _repo = Repository();
  final _bloc = AddFlashcardBloc(repo: _repo);
  static const wFactor = 0.65;

  String question, answer, hint;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add flashcard')),
      body: Container(
        child:BlocProvider(
          create: (context) => _bloc,
          child: BlocListener<AddFlashcardBloc, AddFlashcardState>(
            listener: (context, state) {
              if(state is AddedState && state.isSucc)
                _showResponse(context);
            },
            child: BlocBuilder<AddFlashcardBloc, AddFlashcardState>(
              builder: (context, state) 
              {
                return Center(child: SingleChildScrollView(
                  child:
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text('Question*', style: AppText.LABEL_TEXT),
                            Padding(padding: EdgeInsets.all(10),),
                            Container(
                              width: MediaQuery.of(context).size.width * wFactor,
                              child: TextField(
                                onChanged: (text) => question = text,
                            )),
                          ]
                        ),
                        if(state is ErrorState && state.question != Validator.SUCCESS)
                              Text(_errorText(state.question), style: AppText.ERROR_TEXT,),
                        Padding(padding: EdgeInsets.all(20),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text('Answer*', style: AppText.LABEL_TEXT),
                            Padding(padding: EdgeInsets.all(10),),
                            Container(
                              width: MediaQuery.of(context).size.width * wFactor,
                              child: TextField(
                                onChanged: (text) => answer = text,
                            )),
                          ]),
                        if(state is ErrorState && state.answer != Validator.SUCCESS)
                            Text(_errorText(state.answer), style: AppText.ERROR_TEXT),
                        Padding(padding: EdgeInsets.all(20),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Text('Hint', style: AppText.LABEL_TEXT),
                            Padding(padding: EdgeInsets.all(20),),
                            Container(
                              width: MediaQuery.of(context).size.width * wFactor,
                              child: TextField(
                                onChanged: (text) => hint = text
                            )),
                          ]),
                        if(state is ErrorState && state.hint != Validator.SUCCESS)
                          Text(_errorText(state.hint), style: AppText.ERROR_TEXT,),
                        Padding(padding: EdgeInsets.all(30),),
                        RaisedButton(
                          onPressed: () => _bloc.onAdd(question, answer, hint),
                          child: Text('Submit'),
                        ),
                      ]
                    )
                  )
                );
              }
            ),
          ),
        )
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

void _showResponse(BuildContext context) {
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
}