import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presensi/app/controllers/user_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:presensi/model/user.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  late final Rx<User?> authUser;
  final userController = Get.put(UserController());

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5));
    authUser = Rx<User?>(auth.currentUser);
    authUser.bindStream(auth.userChanges());
    ever(authUser, (callback) => setInitial);
  }

  setInitial(User user) {
    // ignore: unnecessary_null_comparison
    user == null ? Get.offAllNamed(Routes.LOGIN) : Get.offAllNamed(Routes.HOME);
  }

  Future<void> signInWithEmailAndPassword(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      authUser.value != null
          ? Get.offAllNamed(Routes.HOME)
          : Get.offAllNamed(Routes.LOGIN);
      Get.snackbar("Success", "successfully log in to the app");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        Get.snackbar("Error", "Invalid email or password");
      } else {
        Get.snackbar("Error", "An error occurred: ${e.code}");
      }
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String fullname, String password, String telp) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userController.createUser(UserModel(
          fullname: fullname, email: email, telp: telp, password: password));
      Get.toNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", "The email address is already in use");
      } else {
        Get.snackbar("Error", "An error occurred: ${e.code}");
      }
    }
  }
}
