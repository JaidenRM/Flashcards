import 'package:meta/meta.dart';

abstract class ManageFlashcardEvent { }

class AddFlashcardEvent extends ManageFlashcardEvent {
  final String question, answer, hint;

  AddFlashcardEvent({ @required this.question, @required this.answer, this.hint }): assert(question != null && answer != null);
}
class FetchFlashcardEvent extends ManageFlashcardEvent {
  final String filter;

  FetchFlashcardEvent({ this.filter });
}

class UpdateStateEvent extends ManageFlashcardEvent {
  final bool isRight, isWrong, isLiked;

  UpdateStateEvent({this.isRight, this.isWrong, this.isLiked});
}