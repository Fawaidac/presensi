import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> register(String email, password) async {
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return uc.user;
    } catch (e) {
      print("Some Error$e");
    }
    return null;
  }

  Future<User?> login(String email, password) async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return uc.user;
    } catch (e) {
      print("Some Error$e");
    }
    return null;
  }
}
