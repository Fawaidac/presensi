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

  void signIn(String email, String password) async {
    controller.signInWithEmailAndPassword(email, password);
  }
}
