import 'package:quiz_app/models/quiz_item.dart';

class Result {
  final bool won;
  final int score;
  final int correctAnswers;
  final int totalQuestions;
  final String minutesSpent;

  const Result({
    this.score,
    this.correctAnswers,
    this.totalQuestions,
    this.minutesSpent,
  }) : won = score >= 60;

  factory Result.calculate(
    List<int> selectedAnswers,
    List<QuizItem> quizItems, {
    DateTime startTime,
    DateTime endTime,
  }) {
    // check answers
    int correctAnswers = 0;
    quizItems.asMap().forEach((index, item) {
      if (item.correctAnswerIndex == selectedAnswers[index]) {
        correctAnswers++;
      }
    });

    // calculate minutes spent
    Duration diff = endTime.difference(startTime);
    List<String> time = diff.toString().split('.').first.split(':');

    return new Result(
      correctAnswers: correctAnswers,
      totalQuestions: quizItems.length,
      minutesSpent: '${time[1]}:${time[2]}',
      score: (correctAnswers / quizItems.length * 100).toInt(),
    );
  }
}
