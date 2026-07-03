import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../data/models/sensor_log_model.dart';

class CsvExporter {
  /// Ubah list sensor log jadi string CSV.
  /// Header dibuat sama persis dengan format CSV dari ESP32.
  static String buildCsv(List<SensorLogModel> logs) {
    final buffer = StringBuffer();

    buffer.writeln(
      'timestamp,soil_moisture,soil_temperature,air_temperature,'
      'air_humidity,nitrogen,fosfor,kalium,ec',
    );

    for (final log in logs) {
      final ts = log.recordedAt.toUtc().toIso8601String();
      buffer.writeln(
        '$ts,'
        '${log.kelembapanTanah},'
        '0,' // soil_temperature — SensorLogModel belum punya suhuTanah
        '${log.suhu},'
        '${log.kelembapanUdara},'
        '${log.nitrogen},'
        '${log.phosphor},'
        '${log.kalium},'
        '${log.ec}',
      );
    }

    return buffer.toString();
  }

  /// Ambil sudah-jadi CSV string, tulis ke file sementara, lalu buka share sheet.
  static Future<void> shareCsv(String csvString, String deviceId) async {
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/sensor_log_${deviceId}_$stamp.csv');
    await file.writeAsString(csvString);

    await Share.shareXFiles([XFile(file.path)], text: 'Data sensor $deviceId');
  }
}
