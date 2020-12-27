import 'package:html_unescape/html_unescape.dart';

final unescape = HtmlUnescape();

class QuizItem {
  final String question;
  final String topicName;
  final int correctAnswerIndex;
  final List<dynamic> answers;

  QuizItem({this.topicName, this.question, this.correctAnswerIndex, this.answers});

  factory QuizItem.fromJson(Map<String, Object> json) {
    final String correctAnswer = unescape.convert(json['correct_answer']);

    List<String> answers = new List.from(json['incorrect_answers'])
      ..add(correctAnswer)
      ..map((e) => unescape.convert(e))
      ..shuffle();

    return QuizItem(
      answers: answers,
      question: unescape.convert(json['question']),
      topicName: json['category'],
      correctAnswerIndex: answers.indexOf(correctAnswer),
    );
  }
}
