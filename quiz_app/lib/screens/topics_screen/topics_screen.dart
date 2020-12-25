import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quiz_app/models/topic.dart';

import 'widgets/topic_card/index.dart';

const CircleColor = Colors.indigo;

class TopicsScreen extends StatelessWidget {
  TopicsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CircleColor,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: CustomPaint(
          painter: Pattern(theme: theme),
          child: Container(
            width: size.width,
            height: size.height,
            margin: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Text('Quiz Topics', style: TextStyle(fontSize: 25, color: Colors.white)),
                SizedBox(
                  height: 50,
                ),
                AnimationLimiter(
                  child: Flexible(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      shrinkWrap: true,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                        bottom: 50,
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      children: List.generate(
                        topics.length,
                        (int index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: 3,
                            position: index,
                            duration: const Duration(milliseconds: 420),
                            child: ScaleAnimation(
                              scale: 0.3,
                              child: TopicCard(topic: topics[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Pattern extends CustomPainter {
  final ThemeData theme;

  Pattern({Listenable repaint, this.theme}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final Paint paint = Paint();

    // Main background setup
    final Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = theme.canvasColor;
    canvas.drawPath(mainBackground, paint);

    // Circle colors
    paint.color = CircleColor;

    //bottom right circle
    canvas.drawCircle(Offset(width, height - (150 / 4)), 150, paint);

    //bottom left circle
    canvas.drawCircle(Offset(0, height + (100 / 4)), 100, paint);

    //top curve
    final Path path = Path();
    path.moveTo(0, size.height * 0.025);
    path.quadraticBezierTo(200, 150, size.width, size.height * 0.025);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(Pattern oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(Pattern oldDelegate) => false;
}
