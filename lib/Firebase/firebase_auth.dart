import 'package:firebase_auth/firebase_auth.dart';

Future<User?> registerWithEmailPassword(String email, String password) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
