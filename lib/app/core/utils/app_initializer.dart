import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:kelola_tani/app/modules/auth/controllers/auth_controller.dart';
import 'package:kelola_tani/firebase_options.dart';

class AppInitializer {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await Future.wait([_initNetwork()]);
      await _initServices();
      await _initRepositories();
      await _initGlobalController();

      await _initNotifications();

      // Logger().i("App Initialization Completed Successfully");
    } catch (e) {
      // Logger().e("App Initialization Failed: $e");
    }
  }

  static Future<void> _initNetwork() async {
    // Logger().i("Network/Core Initialized");
  }

  static Future<void> _initServices() async {
    // Logger().i("Services Initialized");
  }

  static Future<void> _initRepositories() async {
    // Logger().i("Repositories Initialized");
  }

  static Future<void> _initGlobalController() async {
    Get.put(AuthController(), permanent: true);
    // Logger().i("Global Controllers Initialized");
  }

  static Future<void> dispose() async {
    // Logger().i("App Resources Disposed");
  }

  static Future<void> _initNotifications() async {}
}
