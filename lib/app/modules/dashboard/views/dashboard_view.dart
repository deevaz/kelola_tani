import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';
// import 'package:kelola_tani/app/core/services/snackbar_service.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

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
                  child: AppMaterialRound(
                    radius: 12.r,
                    color: Colors.white.withOpacity(0.2),
                    paddingValue: 8.r,
                    elevation: 0,
                    child: Icon(
                      Ionicons.grid_outline,
                      color: AppStyle.white,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    AppMaterialRound(
                      height: 70.w,
                      width: 70.w,
                      radius: 20.r,
                      color: Colors.white.withOpacity(0.2),
                      elevation: 0,
                      child: Icon(
                        Ionicons.person,
                        color: AppStyle.white,
                        size: 35.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selamat Datang",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppStyle.white,
                          ),
                        ),
                        Text(
                          "Petani Modern", // Nama Akun
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Daftar Perangkat",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppStyle.dark,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      padding: EdgeInsets.zero,
                      children: [
                        _buildDeviceCard(
                          "Node Suhu",
                          Ionicons.thermometer_outline,
                        ),
                        _buildDeviceCard("Node Air", Ionicons.water_outline),
                        _buildAddCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceCard(String label, IconData icon) {
    return AppMaterialRound(
      color: AppStyle.light,
      radius: 16.r,
      elevation: 2,
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMaterialRound(
            height: 40.w,
            width: 40.w,
            radius: 12.r,
            color: AppStyle.white,
            elevation: 0,
            child: Icon(icon, color: AppStyle.primary, size: 22.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppStyle.dark,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddCard() {
    return AppMaterialRound(
      color: AppStyle.primary.withOpacity(0.1),
      radius: 16.r,
      elevation: 0,
      borderColor: AppStyle.primary.withOpacity(0.3),
      onTap: () {},
      child: Center(
        child: Icon(Ionicons.add_circle, size: 40.sp, color: AppStyle.primary),
      ),
    );
  }
}
