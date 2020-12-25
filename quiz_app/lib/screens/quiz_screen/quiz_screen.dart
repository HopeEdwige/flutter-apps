import 'package:flutter/material.dart';

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/question.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final Topic topic;

  const QuizScreen({Key key, @required this.questions, this.topic}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Quiz todo'),
    );
  }
}
