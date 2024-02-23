import 'package:get/get.dart';
import 'package:presensi/app/controllers/auth_controller.dart';
import 'package:presensi/app/controllers/user_controller.dart';
import 'package:presensi/services/firebase_services.dart';

class RegisterController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  final userController = Get.put(UserController());
  final controller = Get.find<AuthController>();

  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void signUp(
      String email, String fullname, String password, String telp) async {
    controller.signUpWithEmailAndPassword(email, fullname, password, telp);
  }
}
