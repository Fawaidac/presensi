import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:presensi/model/user.dart';
import 'package:presensi/utils/app.fonts.dart';
import 'package:presensi/utils/app_colors.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: AppFonts.poppins(fontSize: 16, color: blackColor),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: whiteColor,
          shadowColor: Colors.transparent,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left,
                color: blackColor,
              )),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Container(
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  UserModel user = snapshot.data as UserModel;
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade100,
                              radius: 35,
                              child: const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.fullname,
                                  style: AppFonts.poppins(
                                      fontSize: 14,
                                      color: blackColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user.email,
                                  style: AppFonts.poppins(
                                      fontSize: 14,
                                      color: blackColor,
                                      fontWeight: FontWeight.w300),
                                )
                              ],
                            ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            initialValue: user.email,
                            style: AppFonts.poppins(
                                fontSize: 12, color: blackColor),
                            keyboardType: TextInputType.emailAddress,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            decoration: InputDecoration(
                              hintText: "Email",
                              isDense: true,
                              suffixIcon: Icon(Icons.email),
                              hintStyle: AppFonts.poppins(
                                  fontSize: 12, color: Colors.grey),
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
                            textInputAction: TextInputAction.next,
                            initialValue: user.fullname,
                            style: AppFonts.poppins(
                                fontSize: 12, color: blackColor),
                            keyboardType: TextInputType.name,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.singleLineFormatter
                            ],
                            decoration: InputDecoration(
                              hintText: "Fullname",
                              isDense: true,
                              suffixIcon: Icon(Icons.person),
                              hintStyle: AppFonts.poppins(
                                  fontSize: 12, color: Colors.grey),
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
                            textInputAction: TextInputAction.next,
                            initialValue: user.telp,
                            style: AppFonts.poppins(
                                fontSize: 12, color: blackColor),
                            keyboardType: TextInputType.number,
                            enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(12),
                            ],
                            decoration: InputDecoration(
                              hintText: "Telepon",
                              isDense: true,
                              suffixIcon: Icon(Icons.phone),
                              hintStyle: AppFonts.poppins(
                                  fontSize: 12, color: Colors.grey),
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
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                shadowColor: Colors.transparent,
                              ),
                              child: Text(
                                "Save",
                                style: AppFonts.poppins(
                                    fontSize: 12, color: whiteColor),
                              )),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style:
                            AppFonts.poppins(fontSize: 12, color: blackColor),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Something went wrong",
                        style:
                            AppFonts.poppins(fontSize: 12, color: blackColor),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.indigo,
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
