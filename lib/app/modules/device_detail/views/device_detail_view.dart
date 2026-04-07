import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/dashboard_section.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/detail_card.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/history_table.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/menu_card.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/nutrisi_chart.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/sensor_tile.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';

import '../controllers/device_detail_controller.dart';

class DeviceDetailView extends GetView<DeviceDetailController> {
  const DeviceDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.light,
      body: SingleChildScrollView(
        child: Column(
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
      ),
    );
  }
}

Widget _buildDashboardGrid() {
  final controller = Get.find<DeviceDetailController>();
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
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
                    SensorTile(
                      label: 'Suhu',
                      value: '25 C',
                      icon: Ionicons.thermometer,
                      accentColor: Colors.red,
                    ),
                    SizedBox(height: 10.h),
                    SensorTile(
                      label: 'Kelembapan Tanah',
                      value: '45.8 %',
                      icon: Ionicons.water,
                      accentColor: Colors.blue,
                    ),
                    SizedBox(height: 10.h),
                    SensorTile(
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
                    DetailCard(
                      title: 'Target EC',
                      value: '1.6 mS/cm',
                      footer: 'Fase: Vegetatif',
                      icon: Ionicons.leaf,
                      color: AppStyle.primary,
                    ),
                    SizedBox(height: 12.h),
                    DetailCard(
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
            MenuCard(
              label: 'Kendali Pompa\n(Manual/AI)',
              icon: Ionicons.settings,
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
            MenuCard(
              label: 'Catatan',
              icon: Ionicons.document_text,
              color: AppStyle.secondary,
              onTap: () => Get.toNamed('/notes'),
            ),
            SizedBox(width: 12.w),
            MenuCard(
              label: 'Prediksi\nNutrisi (Detail)',
              icon: Ionicons.analytics,
              color: AppStyle.accent,
              onTap: () => Get.toNamed('/ai'),
            ),
          ],
        ),
        SizedBox(height: 20.h),

        Obx(
          () => DashboardSectionCard(
            title: 'Grafik Nutrisi (NPK)',
            dateRangeLabel: controller.chartFilter.value,
            onDateTap: () => controller.pickDateRange(),
            content: const NutrisiChart(),
          ),
        ),

        SizedBox(height: 20.h),

        Obx(
          () => DashboardSectionCard(
            title: 'Tabel History Lingkungan',
            dateRangeLabel: controller.formattedDateRange,
            onDateTap: () => controller.pickDateRange(),
            content: const HistoryTable(),
          ),
        ),
      ],
    ),
  );
}
