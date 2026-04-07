import 'package:date_range_filter/date_range_filter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';

class DeviceDetailController extends GetxController {
  RxString currentMode = 'Otomatis'.obs;
  RxString pumpMode = 'Mati'.obs;
  final chartFilter = 'Harian'.obs;
  final tableFilter = 'Harian'.obs;
  Rxn<DateTimeRange> selectedDateRange = Rxn<DateTimeRange>();

  String get formattedDateRange {
    if (selectedDateRange.value == null) return 'Pilih Tanggal';

    final start = selectedDateRange.value!.start;
    final end = selectedDateRange.value!.end;

    String startStr = "${start.day}/${start.month}/${start.year}";
    String endStr = "${end.day}/${end.month}/${end.year}";

    if (start.day == end.day &&
        start.month == end.month &&
        start.year == end.year) {
      return startStr;
    }

    return "$startStr - $endStr";
  }

  Future<void> pickDateRange() async {
    DateRangeResult? picked = await DateRangeFilter(
      context: Get.context!,
      color: Theme.of(Get.context!).primaryColor,
      labelColor: AppStyle.primary,
      title: 'Pilih Rentang Tanggal',
      todayLabel: 'Hari Ini',
      yesterdayLabel: 'Kemarin',
      last7DaysLabel: '7 Hari Terakhir',
      last30DaysLabel: '30 Hari Terakhir',
      thisMonthLabel: 'Bulan Ini',
      lastMonthLabel: 'Bulan Lalu',
      thisYearLabel: 'Tahun Ini',
      lastYearLabel: 'Tahun Lalu',
      customDateTimeLabel: 'Tanggal Kustom',
      customRangeLabel: 'Rentang Kustom',
    ).getSelectedDate;

    if (picked != null) {
      final normalizedStart = DateTime(
        picked.startDate.year,
        picked.startDate.month,
        picked.startDate.day,
        0,
        0,
        0,
      );

      final normalizedEnd = DateTime(
        picked.endDate.year,
        picked.endDate.month,
        picked.endDate.day,
        23,
        59,
        59,
      );
      selectedDateRange.value = DateTimeRange(
        start: normalizedStart,
        end: normalizedEnd,
      );
      // Nanti load data baru berdasarkan selectedDateRange.value
    }
  }

  void updateChartFilter(String value) => chartFilter.value = value;
  void updateTableFilter(String value) => tableFilter.value = value;

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
