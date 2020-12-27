import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/result.dart';
import 'package:quiz_app/models/quiz_item.dart';

class ResultScreen extends StatelessWidget {
  final Topic topic;
  final Result result;
  final List<QuizItem> quizItems;

  const ResultScreen({
    Key key,
    @required this.result,
    @required this.topic,
    @required this.quizItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    final Color backgroundColor = result.won ? Colors.indigo : Colors.red;
    final Color textColor = result.won ? Colors.indigoAccent : Colors.redAccent;
    final String banner = result.won ? 'happy-win.png' : 'sad-person.png';
    final String headingText = result.won ? 'Congratulations!' : 'Oh noo!';
    final String subheadingText = result.won ? 'New High Score' : 'Better Luck Next Time';

    return Scaffold(
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
            color: backgroundColor,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/$banner',
                          width: size.width / 1.6,
                          alignment: Alignment.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          headingText,
                          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          subheadingText,
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          '${result.score}',
                          style: TextStyle(fontSize: 100, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  AnimationLimiter(
                    child: Flexible(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.15,
                        shrinkWrap: true,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const BouncingScrollPhysics(),
                        children: <Widget>[
                          AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: 0,
                            duration: const Duration(milliseconds: 420),
                            child: ScaleAnimation(
                              scale: 0.3,
                              child: _buildScoreCard(
                                color: textColor,
                                label: 'Correct Answers',
                                score: '${result.correctAnswers}/${result.totalQuestions}',
                              ),
                            ),
                          ),
                          AnimationConfiguration.staggeredGrid(
                            columnCount: 2,
                            position: 1,
                            duration: const Duration(milliseconds: 420),
                            child: ScaleAnimation(
                              scale: 0.3,
                              child: _buildScoreCard(
                                color: textColor,
                                label: 'Minutes spent',
                                score: result.minutesSpent,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/topics');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: Text('Browse topics', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (result.won) {
                            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                          } else {
                            Navigator.pushReplacementNamed(context, '/quiz', arguments: {'quizItems': quizItems, 'topic': topic});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          child: Text(result.won ? 'Close' : 'Replay', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card _buildScoreCard({String label, String score, color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                score,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
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
    paint.color = color;

    //top circle
    canvas.drawCircle(Offset(width / 2, 0), height / 1.5, paint);
  }

  @override
  bool shouldRepaint(Pattern oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Pattern oldDelegate) => false;
}
