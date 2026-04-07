import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanDeviceView extends StatelessWidget {
  const ScanDeviceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.primary,
      body: Stack(
        children: [
          Container(
            height: 320.h,
            width: 1.sw,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: AppButton.icon(
                    elevation: 0,
                    color: AppStyle.white.withOpacity(0.3),
                    onTap: () => Get.toNamed('/account'),
                    icon: Icon(Ionicons.person, color: AppStyle.white),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    AppMaterialRound(
                      height: 70.w,
                      width: 70.w,
                      radius: 20.r,
                      color: AppStyle.white.withOpacity(0.2),
                      elevation: 0,
                      child: Icon(
                        Icons.abc,
                        color: AppStyle.white,
                        size: 35.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Tambahkan Perangkat',
                      style: AppFonts.xxlBold.copyWith(color: AppStyle.surface),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height - 240.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppStyle.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              padding: EdgeInsets.all(24.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Arahkan ke Kode QR Perangkat',
                    style: AppFonts.xlBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    height: 280.h,
                    width: 280.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: MobileScanner(
                        onDetect: (capture) {
                          final List<Barcode> barcodes = capture.barcodes;
                          if (barcodes.isNotEmpty) {
                            print('QR Found: ${barcodes.first.rawValue}');
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  AppButton(
                    onTap: () {
                      DialogService.showInfo(
                        title: 'Berhasil',
                        message: 'Berhasil terkoneksi dengan perangkat!',
                      );
                    },
                    text: 'Hubungkan',
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: AppStyle.primary,
  //     body: Stack(
  //       children: [
  //         Container(
  //           height: 280.h,
  //           width: 1.sw,
  //           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               GestureDetector(
  //                 onTap: () => Get.back(),
  //                 child: AppMaterialRound(
  //                   radius: 12.r,
  //                   color: AppStyle.white.withOpacity(0.2),
  //                   paddingValue: 8.r,
  //                   elevation: 0,
  //                   child: Icon(
  //                     Ionicons.chevron_back,
  //                     color: AppStyle.white,
  //                     size: 24.sp,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 20.h),
  //               Row(
  //                 children: [
  //                   AppMaterialRound(
  //                     height: 60.w,
  //                     width: 60.w,
  //                     radius: 15.r,
  //                     color: AppStyle.white.withOpacity(0.2),
  //                     elevation: 0,
  //                     child: Icon(
  //                       Ionicons.add_outline,
  //                       color: AppStyle.white,
  //                       size: 30.sp,
  //                     ),
  //                   ),
  //                   SizedBox(width: 16.w),
  //                   Text(
  //                     'Tambahkan Perangkat',
  //                     style: AppFonts.xxlBold.copyWith(color: AppStyle.surface),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),

  //         Align(
  //           alignment: Alignment.bottomCenter,
  //           child: Container(
  //             height: Get.height - 200.h,
  //             width: 1.sw,
  //             decoration: BoxDecoration(
  //               color: AppStyle.white,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(40.r),
  //                 topRight: Radius.circular(40.r),
  //               ),
  //             ),
  //             padding: EdgeInsets.all(32.r),
  //             child: Column(
  //               children: [
  //                 Text(
  //                   'Arahkan ke Kode QR Perangkat',
  //                   style: AppFonts.lgBold,
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(height: 30.h),

  //                 // Scanner Placeholder / Camera
  //                 Container(
  //                   height: 280.h,
  //                   width: 280.h,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.shade200,
  //                     borderRadius: BorderRadius.circular(24.r),
  //                   ),
  //                   child: ClipRRect(
  //                     borderRadius: BorderRadius.circular(24.r),
  //                     child: Stack(
  //                       alignment: Alignment.center,
  //                       children: [
  //                         // MobileScanner(
  //                         //   onDetect: (capture) {
  //                         //     final List<Barcode> barcodes = capture.barcodes;
  //                         //     if (barcodes.isNotEmpty) {
  //                         //       print('QR Found: ${barcodes.first.rawValue}');
  //                         //     }
  //                         //   },
  //                         // ),
  //                         Container(
  //                           height: 2.h,
  //                           width: 200.w,
  //                           color: AppStyle.primary.withOpacity(0.5),
  //                         ),
  //                         Icon(
  //                           Ionicons.qr_code_outline,
  //                           size: 80.sp,
  //                           color: Colors.grey.shade400,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),

  //                 const Spacer(),

  //                 // Action Button
  //                 SizedBox(
  //                   width: double.infinity,
  //                   height: 55.h,
  //                   child: ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: AppStyle.primary,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(12.r),
  //                       ),
  //                     ),
  //                     onPressed: () {},
  //                     child: Text(
  //                       'Hubungkan',
  //                       style: AppFonts.mdBold.copyWith(color: AppStyle.white),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 20.h),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
}
