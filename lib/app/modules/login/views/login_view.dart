import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:presensi/utils/app.fonts.dart';
import 'package:presensi/utils/app_colors.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wellcome !",
                style: AppFonts.poppins(
                    fontSize: 20,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Please sign in with your registered account",
                style: AppFonts.poppins(
                    fontSize: 12,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: email,
                  style: AppFonts.poppins(fontSize: 12, color: blackColor),
                  keyboardType: TextInputType.emailAddress,
                  enabled: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  decoration: InputDecoration(
                    hintText: "Email",
                    isDense: true,
                    suffixIcon: Icon(Icons.email),
                    hintStyle:
                        AppFonts.poppins(fontSize: 12, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 30),
                  child: Obx(
                    () => TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: password,
                      obscureText: controller.showPassword.value,
                      style: AppFonts.poppins(fontSize: 12, color: blackColor),
                      keyboardType: TextInputType.emailAddress,
                      enabled: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        hintText: "Password",
                        isDense: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleShowPassword();
                            },
                            icon: controller.showPassword.value
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    size: 20,
                                  )),
                        hintStyle:
                            AppFonts.poppins(fontSize: 12, color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                    ),
                  )),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      controller.signIn(email.text, password.text);
                    },
                    child: Text(
                      'Sign In',
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: AppFonts.poppins(fontSize: 12, color: blackColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    child: Text(
                      "Sign Up Now",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
