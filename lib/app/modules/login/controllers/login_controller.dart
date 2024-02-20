import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presensi/app/controllers/auth_controller.dart';
import 'package:presensi/services/firebase_services.dart';

class LoginController extends GetxController {
  final controller = Get.find<AuthController>();

  FirebaseAuthServices services = FirebaseAuthServices();

  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void loginUser(String email, String password) {
    controller.signInWithEmailAndPassword(email, password);
  }
}
