import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presensi/app/controllers/auth_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:presensi/services/firebase_services.dart';

class LoginController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  final controller = Get.find<AuthController>();

  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  @override
  void onReady() {
    super.onReady();

    Future.delayed(const Duration(seconds: 6));
    User? user = firebaseAuthServices.getCurrentUser();
    if (user != null) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  void loginUser(String email, String password) async {
    User? user = await firebaseAuthServices.login(email, password);

    if (user != null) {
      Get.offAllNamed(Routes.HOME);
      Get.snackbar("Sign-In Success", "Login successful");
    } else {
      Get.snackbar("Sign-In Failed", "Some error happend");
    }
  }

  void signIn(String email, String password) async {
    controller.signInWithEmailAndPassword(email, password);
  }
}
