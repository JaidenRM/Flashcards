import 'package:flashcards/utils/convert.dart';

class FlashcardModel implements ConvertTo {
  String question;
  String answer;
  String hint;

  FlashcardModel(String question, String answer, String hint) {
    this.question = question;
    this.answer = answer;
    this.hint = hint;
  }

  @override
  List<String> toListString() {
    return [question, answer, hint];
  }
}