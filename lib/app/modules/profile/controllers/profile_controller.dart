import 'package:get/get.dart';
import 'package:presensi/app/controllers/auth_controller.dart';
import 'package:presensi/app/controllers/user_controller.dart';

class ProfileController extends GetxController {
  final authController = Get.put(AuthController());
  final userController = Get.put(UserController());

  getUserData() {
    final email = authController.authUser.value?.email;
    if (email != null) {
      return userController.getUserDetail(email);
    } else {
      print("Error get data user email not found");
    }
  }
}
