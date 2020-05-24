import 'package:meta/meta.dart';

abstract class ManageFlashcardEvent { }

class FetchFlashcardEvent extends ManageFlashcardEvent {
  final String filter;

  FetchFlashcardEvent({ this.filter });
}

class UpdateStateEvent extends ManageFlashcardEvent {
  final bool isRight, isWrong, isLiked;

  UpdateStateEvent({this.isRight, this.isWrong, this.isLiked});
}