import 'package:flutter/material.dart';
import 'package:quiz_app/models/result.dart';

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/quiz_item.dart';
import 'package:quiz_app/util/color_utils.dart';

import 'widgets/dot_indicator/index.dart';

class QuizScreen extends StatefulWidget {
  final Topic topic;
  final List<QuizItem> quizItems;

  const QuizScreen({Key key, @required this.quizItems, @required this.topic}) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final DateTime _startTime = DateTime.now();
  int _currentQuestionIndex;
  int _currentSelectedAnswerIndex;
  List<int> _selectedAnswerIndexes;

  @override
  void initState() {
    super.initState();
    _currentQuestionIndex = 0;
    _currentSelectedAnswerIndex = -1;
    _selectedAnswerIndexes = [];
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    final topicColor = widget.topic.iconColor;
    final QuizItem currentQuestion = widget.quizItems[_currentQuestionIndex];

    print('Choose number: ${currentQuestion.correctAnswerIndex + 1}');

    return WillPopScope(
      onWillPop: _handleOnWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          child: CustomPaint(
            painter: Pattern(
              canvasColor: theme.canvasColor,
              color: topicColor,
            ),
            child: Container(
              width: size.width,
              height: size.height,
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    widget.topic.name,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Container(
                    height: 4,
                    width: size.width / 6,
                    color: topicColor,
                    margin: const EdgeInsets.only(top: 8),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  DotIndicator(
                    position: _currentQuestionIndex,
                    dotsCount: widget.quizItems.length,
                    lineColor: Colors.grey,
                    dotColor: Colors.grey[600],
                    completedDotColor: topicColor,
                    completedLineColor: topicColor[700],
                    activeDotColor: Colors.transparent,
                    activeBorderColor: topicColor[400],
                    finishDotColor: Colors.yellow[700],
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: size.height / 30),
                        Text(
                          currentQuestion.question,
                          style: theme.textTheme.headline5,
                        ),
                        SizedBox(height: size.height / 30),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final isSelected = index == _currentSelectedAnswerIndex;
                            return ListTile(
                              selected: isSelected,
                              tileColor: theme.cardColor,
                              selectedTileColor: Colors.yellow[700],
                              onTap: () => _handleAnswerSelection(index),
                              title: Text(currentQuestion.answers[index], style: theme.textTheme.subtitle1),
                              leading: isSelected
                                  ? Icon(Icons.check, color: theme.textTheme.subtitle1.color)
                                  : Icon(Icons.radio_button_unchecked, color: theme.textTheme.subtitle1.color),
                            );
                          },
                          itemCount: currentQuestion.answers.length,
                          separatorBuilder: (BuildContext context, int index) => SizedBox(height: size.height / 40),
                        ),
                        SizedBox(height: size.height / 30),
                        MaterialButton(
                          minWidth: double.maxFinite,
                          disabledColor: Color(topicColor[700].hashCode).withAlpha(90),
                          color: topicColor[700],
                          onPressed: _currentSelectedAnswerIndex == -1 ? null : () => _handleNextClick(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next",
                                style: const TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleAnswerSelection(int index) {
    setState(() {
      _currentSelectedAnswerIndex = index;
    });
  }

  void _handleNextClick(BuildContext context) {
    if (_selectedAnswerIndexes.length < widget.quizItems.length) {
      setState(() {
        _selectedAnswerIndexes.add(_currentSelectedAnswerIndex);
      });
    }

    if (_currentQuestionIndex < (widget.quizItems.length - 1)) {
      setState(() {
        _currentSelectedAnswerIndex = -1;
        _currentQuestionIndex = _currentQuestionIndex + 1;
      });
    } else if (_selectedAnswerIndexes.length == widget.quizItems.length) {
      Result result = Result.calculate(
        _selectedAnswerIndexes,
        widget.quizItems,
        startTime: _startTime,
        endTime: DateTime.now(),
      );

      Navigator.pushReplacementNamed(context, '/result', arguments: {
        'result': result,
        'topic': widget.topic,
        'quizItems': widget.quizItems,
      });
    }
  }

  Future<bool> _handleOnWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text("Are you sure you want to quit the quiz? All your progress will be lost."),
          title: Text("Warning!"),
          actions: <Widget>[
            FlatButton(
              child: Text("Yes"),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text("No"),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }
}

class Pattern extends CustomPainter {
  final Color canvasColor;
  final Color color;

  const Pattern({Listenable repaint, this.canvasColor, this.color}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final Paint paint = Paint();

    // Main background setup
    final Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = canvasColor;
    canvas.drawPath(mainBackground, paint);

    // Circle colors
    paint.color = darken(color, .25);

    final double circleRadius = 150;

    //bottom left circle
    canvas.drawCircle(Offset(-10, height - (circleRadius / 4)), circleRadius, paint);

    //top right circle
    canvas.drawCircle(Offset(width + (circleRadius / 2.1), height / 7), circleRadius, paint);
  }

  @override
  bool shouldRepaint(Pattern oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Pattern oldDelegate) => false;
}
