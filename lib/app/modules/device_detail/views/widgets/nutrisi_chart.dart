import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NutrisiChart extends StatelessWidget {
  const NutrisiChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      padding: EdgeInsets.only(right: 16.w, left: 8.w, top: 16.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Nitrogen (N)', Colors.green),
              SizedBox(width: 12.w),
              _buildLegendItem('Fosfor (P)', Colors.red),
              SizedBox(width: 12.w),
              _buildLegendItem('Kalium (K)', Colors.blue),
            ],
          ),
          SizedBox(height: 16.h),

          Expanded(
            child: LineChart(
              LineChartData(
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
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '1${value.toInt()}:00',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 50,
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
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                minX: 0,
                maxX: 4,
                minY: 0,
                maxY: 200,
                lineBarsData: [
                  _buildLine(const [
                    FlSpot(0, 140),
                    FlSpot(1, 135),
                    FlSpot(2, 150),
                    FlSpot(3, 135),
                    FlSpot(4, 145),
                  ], Colors.green),
                  _buildLine(const [
                    FlSpot(0, 130),
                    FlSpot(1, 125),
                    FlSpot(2, 145),
                    FlSpot(3, 125),
                    FlSpot(4, 135),
                  ], Colors.red),
                  _buildLine(const [
                    FlSpot(0, 40),
                    FlSpot(1, 35),
                    FlSpot(2, 45),
                    FlSpot(3, 35),
                    FlSpot(4, 40),
                  ], Colors.blue),
                ],
              ),
            ),
          ),
        ],
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
            fontSize: 11.sp,
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
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: color,
            strokeWidth: 1.5,
            strokeColor: Colors.white,
          );
        },
      ),
    );
  }
}
