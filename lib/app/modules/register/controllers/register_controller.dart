import 'package:get/get.dart';
import 'package:presensi/app/controllers/auth_controller.dart';

class RegisterController extends GetxController {
  final controller = Get.find<AuthController>();

  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void registerUser(String email, String password) {
    controller.signUpWithEmailAndPassword(email, password);
  }
}
