import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:presensi/app/modules/login/views/login_view.dart';
import 'package:presensi/app/modules/register/views/register_view.dart';
import 'package:presensi/utils/app.fonts.dart';
import 'package:presensi/utils/app_colors.dart';

import '../controllers/wellcome_controller.dart';

class WellcomeView extends GetView<WellcomeController> {
  WellcomeView({Key? key}) : super(key: key);

  final controller = Get.put(WellcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TabBarView(
                          controller: controller.tabController,
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [LoginView()],
                              ),
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [RegisterView()],
                              ),
                            ),
                          ]),
                    )),
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 15, left: 15),
                  child: Padding(
                    padding: EdgeInsets.all(3),
                    child: TabBar(
                        controller: controller.tabController,
                        unselectedLabelColor: Colors.black,
                        labelColor: blackColor,
                        labelStyle: AppFonts.poppins(
                            fontSize: 12,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                        unselectedLabelStyle: AppFonts.poppins(
                            fontSize: 12,
                            color: blackColor,
                            fontWeight: FontWeight.w500),
                        isScrollable: false,
                        indicator: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        tabs: const [
                          Tab(text: "Sign In"),
                          Tab(text: "Sign Up"),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
