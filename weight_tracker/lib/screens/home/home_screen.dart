import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:weight_tracker/auth.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/models/session.dart';
import 'package:weight_tracker/screens/home/widgets/chart/index.dart';
import 'package:weight_tracker/screens/home/widgets/header/index.dart';
import 'package:weight_tracker/screens/home/widgets/history/index.dart';
import 'package:weight_tracker/screens/home/widgets/progress/index.dart';
import 'package:weight_tracker/screens/home/widgets/bmi_calculator/index.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements AuthStateListener {
  AuthStateProvider authStateProvider;

  @override
  void initState() {
    authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
    super.initState();
  }

  @override
  void onAuthStateChanged(AuthState state, User user) {
    if (state == AuthState.LOGGED_OUT) Navigator.pushReplacementNamed(context, '/sign-up');
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    bool isReady = authStateProvider.ready;
    double currentWeight = 85.30;

    //todo find a better solution :(
    if (!isReady) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Consumer<Session>(
              builder: (context, session, child) => Header(name: session.user?.name),
            ),
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Stack(
          children: [
            Consumer<Session>(
              builder: (context, session, child) => ListView(
                children: <Widget>[
                  Chart(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Progress(
                      current: 78.4,
                      target: session.user?.targetWeight,
                      initial: session.user?.initialWeight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: BMICalculator(
                      currentWeight: currentWeight,
                      user: session.user,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: History(),
                  ),
                ],
              ),
            ),
            Positioned(
              height: 100,
              width: size.width,
              top: (size.height - kToolbarHeight) / 1.17,
              child: new Container(
                height: 80.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: const Alignment(0.0, -1.0),
                    end: const Alignment(0.0, 0.2),
                    colors: <Color>[
                      theme.colorScheme.background.withOpacity(.2),
                      theme.colorScheme.background.withOpacity(.4),
                      theme.colorScheme.background.withOpacity(.8),
                      // Colors.red,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 0),
        width: MediaQuery.of(context).size.width / 1.5,
        height: 55,
        child: FloatingActionButton.extended(
          onPressed: () {},
          label: Text(
            'NEW WEIGHT',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
