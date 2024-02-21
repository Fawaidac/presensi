import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> register(String email, password) async {
    try {
      UserCredential uc = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The email address is already in use");
      } else {
        Get.snackbar("Error", "An error occurred: ${e.code}");
      }
    }
    return null;
  }

  Future<User?> login(String email, password) async {
    try {
      UserCredential uc = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Get.snackbar("Error", "Invalid email or password");
      } else {
        Get.snackbar("Error", "An error occurred: ${e.code}");
      }
    }
    return null;
  }

  User? getCurrentUser() {
    User? user = auth.currentUser;
    return user;
  }
}
