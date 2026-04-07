import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

import '../controllers/device_detail_controller.dart';

class DeviceDetailView extends GetView<DeviceDetailController> {
  const DeviceDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.light,
      body: Column(
        children: [
          AppHeader(
            leading: Row(
              children: [
                Text(
                  'Perangkat 1',
                  style: AppFonts.xlSemiBold.copyWith(color: AppStyle.white),
                ),
                SizedBox(width: 5.w),
                Icon(Icons.circle, color: Colors.blue, size: 12.sp),
              ],
            ),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.asset(
                'assets/icons/app_icon.png',
                height: 40.w,
                width: 40.w,
              ),
            ),
          ),
          _buildDashboardGrid(),
        ],
      ),
    );
  }
}

Widget _buildDashboardGrid() {
  final controller = Get.find<DeviceDetailController>();
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
    child: Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    _buildSensorTile(
                      label: 'Suhu',
                      value: '25 C',
                      icon: Ionicons.thermometer,
                      accentColor: Colors.red,
                    ),
                    SizedBox(height: 10.h),
                    _buildSensorTile(
                      label: 'Kelembapan Tanah',
                      value: '45.8 %',
                      icon: Ionicons.water,
                      accentColor: Colors.blue,
                    ),
                    SizedBox(height: 10.h),
                    _buildSensorTile(
                      label: 'Kelembapan Udara',
                      value: '55 %',
                      icon: Ionicons.cloudy,
                      accentColor: Colors.green,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    _buildDetailCard(
                      title: 'Target EC',
                      value: '1.6 mS/cm',
                      footer: 'Fase: Vegetatif',
                      icon: Ionicons.leaf,
                      color: AppStyle.primary,
                    ),
                    SizedBox(height: 12.h),
                    _buildDetailCard(
                      title: 'Durasi Pompa',
                      value: '15 Menit',
                      data: 'Debit: 20 mL/S',
                      footer: 'Pompa: Aktif',
                      icon: Ionicons.timer,
                      color: AppStyle.accent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.h),
        Row(
          children: [
            _buildMenuCard(
              label: 'Kendali Pompa\n(Manual/AI)',
              icon: Ionicons.settings,
              flex: 1,
              color: AppStyle.primary,
              onTap: () {
                DialogService.controlMode(
                  currentMode: controller.currentMode,
                  pumpMode: controller.pumpMode,
                  onPumpModeSelected: (newPumpMode) {
                    controller.updatePumpMode(newPumpMode);
                    print('Pump mode updated to: $newPumpMode');
                  },
                  onModeSelected: (newMode) {
                    controller.updateMode(newMode);
                    print('Mode updated to: $newMode');
                  },
                );
              },
            ),
            SizedBox(width: 12.w),
            _buildMenuCard(
              label: 'Catatan',
              icon: Ionicons.document_text,
              flex: 1,
              color: AppStyle.secondary,
            ),
            SizedBox(width: 12.w),
            _buildMenuCard(
              label: 'Prediksi\nNutrisi (Detail)',
              icon: Ionicons.analytics,
              flex: 1,
              color: AppStyle.accent,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSensorTile({
  required String label,
  required String value,
  required IconData icon,
  required Color accentColor,
}) {
  return AppMaterialRound(
    color: AppStyle.white,
    paddingValue: 12.r,
    radius: 20.r,
    elevation: 2,
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, size: 20.sp, color: accentColor),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5.h,
          children: [
            Text(label, style: AppFonts.xsRegular.copyWith(color: Colors.grey)),
            Text(value, style: AppFonts.lgBold),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDetailCard({
  required String title,
  required String value,
  String? data,
  required String footer,
  required IconData icon,
  required Color color,
}) {
  return Expanded(
    child: AppMaterialRound(
      color: AppStyle.white,
      paddingValue: 12.r,
      radius: 15.r,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppFonts.smRegular),
              Text(value, style: AppFonts.xxlBold),
              Text(footer, style: AppFonts.xsMedium),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(icon, color: color, size: data != null ? 45.sp : 50.sp),
              const Spacer(),
              if (data != null) Text(data, style: AppFonts.xsRegular),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildMenuCard({
  required String label,
  required IconData icon,
  required int flex,
  required Color color,
  VoidCallback? onTap,
}) {
  return Expanded(
    flex: flex,
    child: InkWell(
      onTap: onTap,
      child: AppMaterialRound(
        color: AppStyle.white,
        paddingValue: 8.r,
        height: 120.h,
        radius: 15.r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60.w,
              width: 60.w,
              decoration: BoxDecoration(
                color: AppStyle.light,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 35.sp),
            ),
            const Spacer(),
            Text(label, style: AppFonts.mdMedium),
          ],
        ),
      ),
    ),
  );
}
