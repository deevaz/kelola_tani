import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/services/firestore_service.dart';
import 'package:kelola_tani/app/data/models/sensor_log_model.dart';

class AiController extends GetxController {
  final RxBool showRecommendations = false.obs;
  final RxBool isLoading = false.obs;
  final plantAgeController = TextEditingController();

  String deviceName = Get.arguments?['deviceName'] ?? 'Perangkat';
  String deviceId = Get.arguments?['deviceId'] ?? '';

  final Rxn<SensorLogModel> latestSensor = Rxn<SensorLogModel>();

  // Hasil prediksi
  final RxString recommendation = ''.obs;
  final RxInt recommendationCode = 0.obs;
  final RxString fase = ''.obs;
  final RxDouble confidence = 0.0.obs;
  final RxString lastPredictedAt = ''.obs;

  static const String _baseUrl = 'https://nutrisi-paprika.deevaz.my.id';

  // Key unik per device
  String get _prefKey => 'last_predict_$deviceId';

  @override
  void onInit() {
    super.onInit();
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isNotEmpty && deviceId.isNotEmpty) {
      latestSensor.bindStream(
        FirestoreService.to.streamLatestSensorLog(uid, deviceId),
      );
    }
    _loadLastPrediction();
  }

  @override
  void onClose() {
    plantAgeController.dispose();
    super.onClose();
  }

  // Load hasil predict terakhir dari local
  Future<void> _loadLastPrediction() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefKey);
    if (raw == null) return;

    final data = jsonDecode(raw);
    recommendation.value = data['recommendation'] ?? '';
    recommendationCode.value = data['recommendation_code'] ?? 0;
    fase.value = data['fase'] ?? '';
    confidence.value = (data['confidence'] ?? 0).toDouble();
    lastPredictedAt.value = data['predicted_at'] ?? '';
    showRecommendations.value = recommendation.value.isNotEmpty;
  }

  // Simpan hasil predict ke local
  Future<void> _saveLastPrediction() async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'recommendation': recommendation.value,
      'recommendation_code': recommendationCode.value,
      'fase': fase.value,
      'confidence': confidence.value,
      'predicted_at': DateTime.now().toIso8601String(),
    };
    await prefs.setString(_prefKey, jsonEncode(data));
    lastPredictedAt.value = data['predicted_at'] as String;
  }

  Future<void> predict() async {
    final ageText = plantAgeController.text.trim();
    if (ageText.isEmpty) {
      DialogService.showInfo(
        title: 'Input Kosong',
        message: 'Masukkan umur tanaman dalam hari (HST).',
      );
      return;
    }

    final plantAge = int.tryParse(ageText);
    if (plantAge == null || plantAge < 0) {
      DialogService.showInfo(
        title: 'Input Tidak Valid',
        message: 'Umur tanaman harus berupa angka positif.',
      );
      return;
    }

    final sensor = latestSensor.value;
    if (sensor == null) {
      DialogService.showInfo(
        title: 'Data Sensor Kosong',
        message: 'Data sensor belum tersedia. Tunggu sebentar.',
      );
      return;
    }

    isLoading.value = true;

    try {
      final connect = GetConnect();
      final response = await connect.post('$_baseUrl/predict/pupuk', {
        'nitrogen': sensor.nitrogen,
        'fosfor': sensor.phosphor,
        'kalium': sensor.kalium,
        'plant_age': plantAge,
        'ec': sensor.ec,
        'soil_moisture': sensor.kelembapanTanah,
      });

      if (response.statusCode == 200) {
        final data = response.body;
        recommendation.value = data['recommendation'];
        recommendationCode.value = data['recommendation_code'];
        fase.value = data['fase'];
        confidence.value = (data['confidence'] as num).toDouble();
        showRecommendations.value = true;
        await _saveLastPrediction(); // <-- simpan ke local
      } else {
        DialogService.showInfo(
          title: 'Gagal',
          message: 'Server error: ${response.statusCode}',
        );
      }
    } catch (e) {
      DialogService.showInfo(
        title: 'Koneksi Gagal',
        message: 'Tidak bisa terhubung ke server prediksi.',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
