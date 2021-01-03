import 'package:weight_tracker/models/user.dart';
import 'package:weight_tracker/services/db_service.dart';

enum AuthState { LOGGED_IN, LOGGED_OUT }

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state, User user);
}

class AuthStateProvider {
  static final AuthStateProvider _instance = new AuthStateProvider.internal();

  bool _isLoading = true;
  List<AuthStateListener> _subscribers;

  factory AuthStateProvider() => _instance;

  bool get ready => !_isLoading;

  AuthStateProvider.internal() {
    _subscribers = new List<AuthStateListener>();
    initState();
  }

  void initState() async {
    final DBService db = new DBService();
    final bool isLoggedIn = await db.isLoggedIn();

    if (isLoggedIn) {
      final Map currentUserMap = await db.currentUser();
      final User currentUser = User.fromMap(currentUserMap);
      notify(AuthState.LOGGED_IN, currentUser);
    } else {
      notify(AuthState.LOGGED_OUT);
    }

    _isLoading = false;
  }

  void subscribe(AuthStateListener listener) {
    _subscribers.add(listener);
  }

  void unsubscribe(AuthStateListener listener) {
    _subscribers.remove(listener);
  }

  void dispose(AuthStateListener listener) {
    for (var l in _subscribers) {
      if (l == listener) _subscribers.remove(l);
    }
  }

  void notify(AuthState state, [User user]) {
    _subscribers.forEach((AuthStateListener s) => s.onAuthStateChanged(state, user));
  }
}
