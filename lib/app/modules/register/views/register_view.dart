import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:presensi/app/controllers/user_controller.dart';
import 'package:presensi/app/routes/app_pages.dart';
import 'package:presensi/utils/app.fonts.dart';
import 'package:presensi/utils/app_colors.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final fullname = TextEditingController();
  final email = TextEditingController();
  final telp = TextEditingController();
  final password = TextEditingController();

  @override
  final controller = Get.put(RegisterController());

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
                "Create Account",
                style: AppFonts.poppins(
                    fontSize: 20,
                    color: blackColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Please create your account now",
                style: AppFonts.poppins(
                    fontSize: 12,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
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
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: fullname,
                  style: AppFonts.poppins(fontSize: 12, color: blackColor),
                  keyboardType: TextInputType.name,
                  enabled: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  decoration: InputDecoration(
                    hintText: "Fullname",
                    isDense: true,
                    suffixIcon: Icon(Icons.person),
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
                padding: const EdgeInsets.only(top: 15),
                child: TextFormField(
                  controller: telp,
                  style: AppFonts.poppins(fontSize: 12, color: blackColor),
                  keyboardType: TextInputType.name,
                  enabled: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(12)
                  ],
                  decoration: InputDecoration(
                    hintText: "Telp",
                    isDense: true,
                    suffixIcon: Icon(Icons.phone),
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
                      controller.signUp(email.text.trim(), fullname.text.trim(),
                          password.text.trim(), telp.text.trim());
                    },
                    child: Text(
                      'Sign Up',
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
                    "Already have an account ? ",
                    style: AppFonts.poppins(fontSize: 12, color: blackColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "Sign In",
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
