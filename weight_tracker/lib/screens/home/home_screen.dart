import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:weight_tracker/auth.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/models/session.dart';
import 'package:weight_tracker/screens/home/widgets/chart/index.dart';
import 'package:weight_tracker/screens/home/widgets/header/index.dart';
import 'package:weight_tracker/screens/home/widgets/progress/index.dart';

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
    bool isReady = authStateProvider.ready;

    //todo find a better solution :(
    if (!isReady) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
            child: Consumer<Session>(
              builder: (context, session, child) => Column(
                children: <Widget>[
                  Header(name: session.user?.name),
                  Chart(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Progress(
                      current: 85,
                      target: session.user?.targetWeight,
                      initial: session.user?.initialWeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
