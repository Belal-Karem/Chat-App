import 'package:firebase_auth/firebase_auth.dart';

Future<void> registreUser(
    {required String email, required String password}) async {
  UserCredential user = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
}

Future<void> loginUser(
    {required String email, required String password}) async {
  UserCredential user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
}
