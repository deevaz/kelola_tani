import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'dart:math' as math;

import '../../controllers/device_detail_controller.dart';

class HistoryTable extends StatefulWidget {
  const HistoryTable({super.key});

  @override
  State<HistoryTable> createState() => _HistoryTableState();
}

class _HistoryTableState extends State<HistoryTable> {
  bool _showChart = false;
  int _currentPage = 0;
  final int _rowsPerPage = 10;

  final ScrollController _headerScrollController = ScrollController();
  final ScrollController _bodyScrollController = ScrollController();
  final ScrollController _chartScrollController = ScrollController();

  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();

    _bodyScrollController.addListener(() {
      if (_isSyncing) return;
      if (_headerScrollController.hasClients &&
          _bodyScrollController.hasClients) {
        _isSyncing = true;
        _headerScrollController.jumpTo(_bodyScrollController.offset);
        _isSyncing = false;
      }
    });

    _headerScrollController.addListener(() {
      if (_isSyncing) return;
      if (_headerScrollController.hasClients &&
          _bodyScrollController.hasClients) {
        _isSyncing = true;
        _bodyScrollController.jumpTo(_headerScrollController.offset);
        _isSyncing = false;
      }
    });
  }

  @override
  void dispose() {
    _headerScrollController.dispose();
    _bodyScrollController.dispose();
    _chartScrollController.dispose();
    super.dispose();
  }

  void _nextPage(int totalPages) {
    if (_currentPage < totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  double _getColumnWidth(int index) {
    switch (index) {
      case 0:
        return 60.w;
      case 1:
        return 40.w;
      case 2:
        return 40.w;
      case 3:
        return 40.w;
      case 4:
        return 50.w;
      case 5:
        return 70.w;
      case 6:
        return 70.w;
      default:
        return 50.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DeviceDetailController>();

    return Obx(() {
      final logs = controller.tableLogs;

      if (logs.isEmpty) {
        return Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Center(child: Text('Belum ada data riwayat')),
        );
      }

      int totalPages = (logs.length / _rowsPerPage).ceil();

      if (_currentPage >= totalPages && totalPages > 0) {
        _currentPage = totalPages - 1;
      }
      if (totalPages == 0) _currentPage = 0;

      final paginatedLogs = logs
          .skip(_currentPage * _rowsPerPage)
          .take(_rowsPerPage)
          .toList();

      return Container(
        height: _showChart ? 390.h : 350.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildViewToggle(),
            if (_showChart)
              Expanded(child: _buildChartView(logs.toList()))
            else ...[
              Container(
                decoration: BoxDecoration(color: Colors.green.shade100),
                child: SingleChildScrollView(
                  controller: _headerScrollController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Row(
                      children: [
                        _buildHeaderCell('Waktu', 0),
                        _buildHeaderCell('N', 1),
                        _buildHeaderCell('P', 2),
                        _buildHeaderCell('K', 3),
                        _buildHeaderCell('Suhu', 4),
                        _buildHeaderCell('Kel.Tanah', 5),
                        _buildHeaderCell('Kel.Udara', 6),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    controller: _bodyScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: paginatedLogs.map((log) {
                          final time = log.recordedAt.toLocal();
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade100),
                              ),
                            ),
                            child: Row(
                              children: [
                                _buildDataCell(
                                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                                  0,
                                ),
                                _buildDataCell(
                                  log.nitrogen.toStringAsFixed(0),
                                  1,
                                ),
                                _buildDataCell(
                                  log.phosphor.toStringAsFixed(0),
                                  2,
                                ),
                                _buildDataCell(
                                  log.kalium.toStringAsFixed(0),
                                  3,
                                ),
                                _buildDataCell(log.suhu.toStringAsFixed(1), 4),
                                _buildDataCell(
                                  log.kelembapanTanah.toStringAsFixed(0),
                                  5,
                                ),
                                _buildDataCell(
                                  log.kelembapanUdara.toStringAsFixed(0),
                                  6,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        color: _currentPage > 0
                            ? AppStyle.primary
                            : Colors.grey.shade400,
                      ),
                      onPressed: _currentPage > 0 ? _prevPage : null,
                    ),
                    Text(
                      'Halaman ${_currentPage + 1} dari $totalPages',
                      style: AppFonts.smSemiBold.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: _currentPage < totalPages - 1
                            ? AppStyle.primary
                            : Colors.grey.shade400,
                      ),
                      onPressed: _currentPage < totalPages - 1
                          ? () => _nextPage(totalPages)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildViewToggle() {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(2.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToggleButton(
                  icon: Icons.table_chart_outlined,
                  label: 'Tabel',
                  isSelected: !_showChart,
                  onTap: () => setState(() => _showChart = false),
                ),
                SizedBox(width: 2.w),
                _buildToggleButton(
                  icon: Icons.show_chart,
                  label: 'Grafik',
                  isSelected: _showChart,
                  onTap: () => setState(() => _showChart = true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppStyle.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartView(List logs) {
    final reversed = logs.reversed.toList();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Suhu (°C)', Colors.orange),
              SizedBox(width: 10.w),
              _buildLegendItem('Kel.Tanah (%)', AppStyle.primary),
              SizedBox(width: 10.w),
              _buildLegendItem('Kel.Udara (%)', Colors.lightBlue),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, right: 4.w, bottom: 8.h),
            child: _buildLineChart(reversed),
          ),
        ),
      ],
    );
  }

  Widget _buildLineChart(List logs) {
    if (logs.isEmpty) return const SizedBox();

    double chartWidth = math.max(
      logs.length * 40.w,
      MediaQuery.of(context).size.width - 50.w,
    );

    double dataMax = 0;
    for (final log in logs) {
      dataMax = math.max(dataMax, log.suhu);
      dataMax = math.max(dataMax, log.kelembapanTanah);
      dataMax = math.max(dataMax, log.kelembapanUdara);
    }
    double maxY = (dataMax * 1.15).ceilToDouble();
    if (maxY < 50) maxY = 50;

    final lines = [
      _buildLine(
        logs
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.suhu))
            .toList(),
        Colors.orange,
      ),
      _buildLine(
        logs
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.kelembapanTanah))
            .toList(),
        AppStyle.primary,
      ),
      _buildLine(
        logs
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value.kelembapanUdara))
            .toList(),
        Colors.lightBlue,
      ),
    ];

    return SingleChildScrollView(
      controller: _chartScrollController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      child: Container(
        width: chartWidth,
        padding: EdgeInsets.only(right: 16.w, top: 8.h),
        child: LineChart(
          LineChartData(
            clipData: FlClipData.all(),
            maxX: (logs.length - 1).toDouble(),
            minY: 0,
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: Colors.grey.shade300, strokeWidth: 1),
              getDrawingVerticalLine: (value) =>
                  FlLine(color: Colors.grey.shade300, strokeWidth: 1),
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= logs.length) {
                      return const SizedBox();
                    }
                    final time = logs[index].recordedAt.toLocal();
                    return Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: maxY > 200 ? 50 : (maxY > 100 ? 25 : 10),
                  reservedSize: 30,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    );
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (touchedSpot) => Colors.grey.shade800,
                // tooltipRoundedRadius: 8,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    String label;
                    switch (spot.barIndex) {
                      case 0:
                        label = 'Suhu';
                        break;
                      case 1:
                        label = 'Kel.Tanah';
                        break;
                      case 2:
                        label = 'Kel.Udara';
                        break;
                      default:
                        label = '';
                    }
                    return LineTooltipItem(
                      '$label: ${spot.y.toStringAsFixed(1)}',
                      TextStyle(
                        color: spot.bar.color,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey.shade300),
            ),
            lineBarsData: lines,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  LineChartBarData _buildLine(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 3,
          color: color,
          strokeWidth: 1.5,
          strokeColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String label, int index) {
    return SizedBox(
      width: _getColumnWidth(index),
      child: Text(
        label,
        style: AppFonts.smBold.copyWith(color: Colors.green.shade800),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataCell(String value, int index) {
    return SizedBox(
      width: _getColumnWidth(index),
      child: Text(
        value,
        style: AppFonts.smRegular.copyWith(color: Colors.black87),
        textAlign: TextAlign.center,
      ),
    );
  }
}
