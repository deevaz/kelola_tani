import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';

class HistoryTable extends StatelessWidget {
  const HistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.green.shade100),
              dataRowMinHeight: 40.h,
              dataRowMaxHeight: 45.h,
              columnSpacing: 25.w,
              columns: [
                _buildColumn('Waktu'),
                _buildColumn('N'),
                _buildColumn('P'),
                _buildColumn('K'),
                _buildColumn('Suhu'),
                _buildColumn('Kelembapan\nTanah'),
                _buildColumn('Kelembapan\nUdara'),
                _buildColumn('EC Air'),
              ],
              rows: [
                _buildRow([
                  '09:11',
                  '40',
                  '139',
                  '132',
                  '25.9',
                  '76',
                  '55',
                  '1.6',
                ]),
                _buildRow([
                  '09:16',
                  '39',
                  '136',
                  '129',
                  '26.8',
                  '55',
                  '56',
                  '1.6',
                ]),
                _buildRow([
                  '09:21',
                  '38',
                  '134',
                  '127',
                  '27.9',
                  '55',
                  '58',
                  '1.5',
                ]),
                _buildRow([
                  '09:26',
                  '37',
                  '133',
                  '126',
                  '28.9',
                  '54',
                  '60',
                  '1.5',
                ]),
                _buildRow([
                  '09:32',
                  '37',
                  '131',
                  '124',
                  '29.5',
                  '55',
                  '61',
                  '1.4',
                ]),
                _buildRow([
                  '09:37',
                  '36',
                  '130',
                  '123',
                  '29.9',
                  '54',
                  '62',
                  '1.4',
                ]),
                _buildRow([
                  '09:42',
                  '36',
                  '128',
                  '121',
                  '30.1',
                  '53',
                  '60',
                  '1.4',
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DataColumn _buildColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: AppFonts.smBold.copyWith(color: Colors.green.shade800),
        textAlign: TextAlign.center,
      ),
    );
  }

  DataRow _buildRow(List<String> values) {
    return DataRow(
      cells: values.map((value) {
        return DataCell(
          Text(
            value,
            style: AppFonts.smRegular.copyWith(color: Colors.black87),
          ),
        );
      }).toList(),
    );
  }
}
