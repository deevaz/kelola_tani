// import 'package:get/get.dart';
// import 'package:kelola_barang/app/data/services/auth_service.dart';
// import 'package:kelola_barang/app/data/services/local_db_service.dart';
// import 'package:kelola_barang/app/data/services/pocketbase_service.dart';
// import 'package:kelola_barang/app/modules/auth/controllers/auth_controller.dart';
// import 'package:kelola_barang/app/modules/auth/repositories/auth_repository.dart';
// import 'package:kelola_barang/app/modules/customer/repositories/customer_repository.dart';
// import 'package:kelola_barang/app/modules/histories/repositories/stock_in_repository.dart';
// import 'package:kelola_barang/app/modules/histories/repositories/stock_out_repository.dart';

// import 'package:kelola_barang/app/modules/products/repositories/product_repository.dart';
// import 'package:kelola_barang/app/modules/stock_transactions/repositories/transaction_repository.dart';
// import 'package:kelola_barang/app/modules/supplier/repositories/supplier_repository.dart';
// import 'package:kelola_barang/app/services/language_service.dart';
// import 'package:kelola_barang/app/services/network_service.dart';
// // import 'package:kelola_barang/app/services/revenue_cat_service.dart';
// // import 'package:logger/logger.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:flutter/foundation.dart';

// class AppInitializer {
//   static Future<void> init() async {
//     try {
//       await Future.wait([
//         _initNetwork(),
//       ]);

//       await _initServices();
//       await _initRepositories();
//       await _initGlobalController();

//       await _initNotifications();

//       // await RevenueCatService.initialize();

//       // Logger().i("App Initialization Completed Successfully");
//     } catch (e) {
//       // Logger().e("App Initialization Failed: $e");
//     }
//   }

//   static Future<void> _initNetwork() async {
//     // Logger().i("Network/Core Initialized");
//   }

//   static Future<void> _initServices() async {
//     await Get.putAsync(() => LanguageService().init());
//     await Get.putAsync(() => LocalDbService().init());
//     await Get.putAsync(() => PocketBaseService().init());

//     final authService = Get.put(AuthService());
//     await authService.loadGuestStatus();
//     Get.put(NetworkService());

//     // Logger().i("Services Initialized");
//   }

//   static Future<void> _initRepositories() async {
//     Get.put(AuthRepository());
//     Get.put(ProductRepository());
//     Get.put(StockInRepository());
//     Get.put(StockOutRepository());
//     Get.put(SupplierRepository());
//     Get.put(CustomerRepository());
//     Get.put(TransactionRepository());
//     // Logger().i("Repositories Initialized");
//   }

//   static Future<void> _initGlobalController() async {
//     Get.put(AuthController(Get.find()), permanent: true);
//     // Logger().i("Global Controllers Initialized");
//   }

//   static Future<void> dispose() async {
//     // Logger().i("App Resources Disposed");
//   }

//   static Future<void> _initNotifications() async {
//     if (kDebugMode) {
//       OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
//     }

//     OneSignal.initialize("36f61729-a631-4f2b-8be4-6d9bb5307f03");

//     OneSignal.Notifications.requestPermission(false);
//   }
// }
