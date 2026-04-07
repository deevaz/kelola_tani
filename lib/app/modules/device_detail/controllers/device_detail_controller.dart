import 'package:get/get.dart';

class DeviceDetailController extends GetxController {
  RxString currentMode = 'Otomatis'.obs;
  RxString pumpMode = 'Mati'.obs;

  void updatePumpMode(String newPumpMode) {
    pumpMode.value = newPumpMode;
  }

  void updateMode(String newMode) {
    currentMode.value = newMode;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
