import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/auth.dart';
import 'package:weight_tracker/models/session.dart';
import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/screens/home_screen/home_screen.dart';
import 'package:weight_tracker/services/db_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> implements AuthStateListener {
  DBService db;
  AuthStateProvider authStateProvider;

  @override
  void initState() {
    db = new DBService();
    authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
        ),
      ),
    );
  }

  @override
  onAuthStateChanged(AuthState state, User user) {
    if (state == AuthState.LOGGED_IN) {
      Provider.of<Session>(context).set(user);

      Navigator.pushReplacement(
          context, PageRouteBuilder(pageBuilder: (context, _, __) => HomeScreen(), transitionDuration: Duration.zero));

//      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  _handleSignUp() async {
    final DBService db = new DBService();
    await db.saveUser(new User("Wali", 1, 25, 10, 90.50, 75));
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
}
