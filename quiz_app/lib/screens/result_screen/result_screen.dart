import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:quiz_app/models/topic.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/util/color_utils.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

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
            color: Colors.indigo,
          ),
          child: Container(
            width: size.width,
            height: size.height,
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(children: <Widget>[
              Image.asset(
                'assets/images/happy-win.png',
                width: size.width / 1.8,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Awesome!',
                style: theme.textTheme.headline3,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '7 of 10',
                style: TextStyle(fontSize: 40, color: Colors.green),
              ),
              Text(
                'answers were correct.',
                style: theme.textTheme.subtitle1,
              ),
              SizedBox(
                height: 10,
              ),
              AnimationLimiter(
                child: Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.25,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      AnimationConfiguration.staggeredGrid(
                        columnCount: 2,
                        position: 2,
                        duration: const Duration(milliseconds: 420),
                        child: ScaleAnimation(
                          scale: 0.3,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [Text('Incorrect Answers'), Text('3/10')],
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimationConfiguration.staggeredGrid(
                        columnCount: 2,
                        position: 3,
                        duration: const Duration(milliseconds: 420),
                        child: ScaleAnimation(
                          scale: 0.3,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [Text('Score'), Text('40.0%')],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MaterialButton(
                minWidth: double.maxFinite,
                color: Colors.indigo,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home),
                    SizedBox(width: 10),
                    Text(
                      "Go Home",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              )
            ]),
          ),
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

    //bottom left circle
    canvas.drawCircle(Offset(0, -30), 50, paint);
    canvas.drawCircle(Offset(width, height - (height / 1.6)), 50, paint);
    canvas.drawCircle(Offset(0, height), 50, paint);
  }

  @override
  bool shouldRepaint(Pattern oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Pattern oldDelegate) => false;
}
