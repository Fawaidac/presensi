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

  Future<UserModel> getUserDetail(String email) async {
    final snapshot =
        await _db.collection("Users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> updateUserProfile(UserModel userModel) async {
    final snapshot = await _db
        .collection("Users")
        .where("email", isEqualTo: userModel.email)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      await _db.collection("Users").doc(docId).update(userModel.toJson());
      Get.snackbar("Success", "Update profile is successfully");
      Get.back();
    } else {
      print("User with email ${userModel.email} not found.");
    }
  }
}
