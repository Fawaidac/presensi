import 'package:get/get.dart';

import '../controllers/wellcome_controller.dart';

class WellcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WellcomeController>(
      () => WellcomeController(),
    );
  }
}
