import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class JbfSFirebaseUser {
  JbfSFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

JbfSFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<JbfSFirebaseUser> jbfSFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<JbfSFirebaseUser>((user) => currentUser = JbfSFirebaseUser(user));
