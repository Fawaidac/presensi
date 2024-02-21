import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:presensi/app/controllers/auth_controller.dart';
import 'package:presensi/app/controllers/user_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:presensi/model/user.dart';
import 'package:presensi/services/firebase_services.dart';

class RegisterController extends GetxController {
  FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();
  final userController = Get.put(UserController());
  final controller = Get.find<AuthController>();

  var showPassword = true.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void signUpUser(
      String email, String fullname, String password, String telp) async {
    User? user = await firebaseAuthServices.register(email, password);

    if (user != null) {
      await userController.createUser(UserModel(
        fullname: fullname,
        email: email,
        telp: telp,
        password: password,
      ));

      Get.offAllNamed(Routes.LOGIN);
      Get.snackbar("Sign-Up Success", "Registration successful");
    } else {
      Get.snackbar("Sign-Up Failed", "Some error happend");
    }
  }

  void signUp(
      String email, String fullname, String password, String telp) async {
    controller.signUpWithEmailAndPassword(email, fullname, password, telp);
  }
}
