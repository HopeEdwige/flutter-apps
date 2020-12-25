enum QuestionType { multiple, boolean }

class Question {
  final String question;
  final String topicName;
  final QuestionType type;
  final int correctAnswerIndex;
  final List<dynamic> answers;

  Question({this.topicName, this.type, this.question, this.correctAnswerIndex, this.answers});

  factory Question.fromJson(Map<String, Object> json) {
    final String correctAnswer = json['correct_answer'];

    List<String> answers = new List.from(json['incorrect_answers'])
      ..add(correctAnswer)
      ..shuffle();

    return Question(
      answers: answers,
      question: json['question'],
      topicName: json['category'],
      correctAnswerIndex: answers.indexOf(correctAnswer),
      type: json['type'] == 'multiple' ? QuestionType.multiple : QuestionType.boolean,
    );
  }
}
