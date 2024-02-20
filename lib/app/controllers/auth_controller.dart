import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presensi/app/exceptions/failure_exception.dart';
import 'package:presensi/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;
  late final Rx<User?> authUser;

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5));
    authUser = Rx<User?>(auth.currentUser);
    authUser.bindStream(auth.userChanges());
    ever(authUser, (callback) => setInitial);
  }

  setInitial(User user) {
    user == null
        ? Get.offAllNamed(Routes.WELLCOME)
        : Get.offAllNamed(Routes.HOME);
  }

  Future<void> signInWithEmailAndPassword(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      authUser.value != null
          ? Get.offAllNamed(Routes.HOME)
          : Get.offAllNamed(Routes.WELLCOME);
    } on FirebaseAuthException catch (e) {
      final ex = FailureException.code(e.code);
      Get.snackbar("Error", ex.msg);
    } catch (e) {
      const ex = FailureException();
      Get.snackbar("Sign-In Error", ex.msg);
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar("Sign-Up Success", "Registration successful");
    } on FirebaseAuthException catch (e) {
      final ex = FailureException.code(e.code);
      Get.snackbar("Error", ex.msg);
    } catch (e) {
      const ex = FailureException();
      Get.snackbar("Sign-Un Error", ex.msg);
    }
  }

  Future<void> logout() async => await auth.signOut();
}
