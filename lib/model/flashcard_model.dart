import 'package:flashcards/utils/convert.dart';

class FlashcardModel implements ConvertTo {
  String question, answer, hint;
  int right, wrong, id;
  bool isLiked;

  FlashcardModel.newModel(String question, String answer, String hint) {
    this.question = question;
    this.answer = answer;
    this.hint = hint;
    this.right = right;
    this.wrong = wrong;
    this.isLiked = isLiked;
  }

  FlashcardModel(String id, String question, String answer, String hint
    , String right, String wrong, String isLiked) {
    this.id = int.tryParse(id) ?? 0;
    this.question = question;
    this.answer = answer;
    this.hint = hint;
    this.right = int.tryParse(right) ?? 0;
    this.wrong = int.tryParse(wrong) ?? 0;
    this.isLiked = isLiked.toLowerCase() == 'true';
  }

  @override
  List<String> toListString() {
    return [id.toString(), question, answer, hint
      , right.toString(), wrong.toString(), isLiked.toString()];
  }
}