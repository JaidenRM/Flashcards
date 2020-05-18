import 'package:meta/meta.dart';

abstract class ManageFlashcardEvent { }

class AddFlashcardEvent extends ManageFlashcardEvent {
  final String question;
  final String answer;
  final String hint;

  AddFlashcardEvent({ @required this.question, @required this.answer, this.hint }): assert(question != null && answer != null);
}
class FetchFlashcardEvent extends ManageFlashcardEvent {
  final String filter;

  FetchFlashcardEvent({ this.filter });
}