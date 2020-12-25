import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: size.height / 5),
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Quiz App',
                  style: theme.textTheme.headline3,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'A simple quiz app.',
                  style: theme.textTheme.subtitle1,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Powered by Flutter and Open Trivia DB API.',
                  style: theme.textTheme.subtitle1,
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        child: Text('Play random topic', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/topics');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        child: Text('Topics', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
