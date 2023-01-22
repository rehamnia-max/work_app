import 'package:dev_mobile_tp/models/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  String? get accessToken => prefs!.getString("token") ?? "";
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<bool> signIn({required String email, required String password}) async {
    bool isSigned = false;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      prefs!.setString("token", currentUser!.uid);
      isSigned = true;
    } on FirebaseAuthException {
      isSigned = false;
    }
    return isSigned;
  }

  Future<bool> creatUser(
      {required String email, required String password}) async {
    bool isSigned = false;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      prefs!.setString("token", currentUser!.uid);
      isSigned = true;
    } on FirebaseAuthException {
      isSigned = false;
    }
    return isSigned;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    prefs!.remove("token");
  }
}
