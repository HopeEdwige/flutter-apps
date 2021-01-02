import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/auth.dart';
import 'package:weight_tracker/models/session.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/screens/home/home_screen.dart';
import 'package:weight_tracker/services/db_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> implements AuthStateListener {
  DBService db;
  BuildContext _ctx;
  AuthStateProvider authStateProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_ctx == null) {
      _ctx = context;
    }
  }

  @override
  void initState() {
    db = new DBService();
    authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
    super.initState();
  }

  @override
  void dispose() {
    authStateProvider.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: authStateProvider.ready
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () => _handleSignUp(),
                        child: Text('Sign up'),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  @override
  onAuthStateChanged(AuthState state, User user) {
    if (state == AuthState.LOGGED_IN) {
      Provider.of<Session>(context).set(user);
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  _handleSignUp() async {
    final DBService db = new DBService();
    final User user = new User("Wali", 1, 25, 10, 90.50, 75);
    await db.saveUser(user);
    authStateProvider.notify(AuthState.LOGGED_IN, user);
  }
}
