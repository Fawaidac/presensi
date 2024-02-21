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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ));
  }
}
