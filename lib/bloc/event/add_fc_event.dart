import 'package:meta/meta.dart';

abstract class AddFlashcardEvent {}

class AddEvent extends AddFlashcardEvent {
  final String question, answer, hint;

  AddEvent({ @required this.question, @required this.answer, this.hint })
    : assert(question != null && answer != null);
}