import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:presensi/model/user.dart';

class UserController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel userModel) async {
    try {
      await _db.collection("Users").add(userModel.toJson());
      Get.snackbar("Success", "Your account has been created successfully");
    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Please try again.");
      print("Error creating user: $error");
    }
  }
}
