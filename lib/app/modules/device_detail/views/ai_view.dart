import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/device_detail/controllers/ai_controller.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';
import 'package:kelola_tani/app/shared/widgets/app_text_field.dart';

class AiView extends GetView<AiController> {
  const AiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.light,
      body: Column(
        children: [
          AppHeader(
            leading: Text(
              'Prediksi Nutrisi',
              style: AppFonts.xlSemiBold.copyWith(color: AppStyle.white),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppStyle.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppStyle.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  'Perangkat: ${controller.deviceName}',
                  style: AppFonts.smBold.copyWith(color: AppStyle.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Masukkan umur tanaman anda :',
                    style: AppFonts.mdSemiBold,
                  ),
                  SizedBox(height: 10.h),
                  AppTextField(
                    controller: controller.plantAgeController,
                    title: 'Contoh: 30',
                    hintText: 'Masukkan umur tanaman dalam hari (HST)',
                    inputType: TextInputType.number,
                  ),
                  SizedBox(height: 16.h),
                  Obx(
                    () => AppButton(
                      onTap: controller.isLoading.value
                          ? null
                          : () => controller.predict(),
                      text: controller.isLoading.value
                          ? 'Memproses...'
                          : 'Hitung',
                      width: double.infinity,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => Visibility(
                      visible: controller.showRecommendations.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppMaterialRound(
                            paddingValue: 16.r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Berikut adalah rata rata kandungan N, P dan K lahan anda :',
                                  style: AppFonts.mdSemiBold,
                                ),
                                SizedBox(height: 12.h),
                                _npkRow(
                                  'Nitrogen',
                                  '(N)',
                                  '${controller.latestSensor.value?.nitrogen ?? 0} mg/kg',
                                ),
                                SizedBox(height: 8.h),
                                _npkRow(
                                  'Phospor',
                                  '(P)',
                                  '${controller.latestSensor.value?.phosphor ?? 0} mg/kg',
                                ),
                                SizedBox(height: 8.h),
                                _npkRow(
                                  'Kalium',
                                  '(K)',
                                  '${controller.latestSensor.value?.kalium ?? 0} mg/kg',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Obx(() {
                            final isNoNeed =
                                controller.recommendationCode.value == 0;
                            return AppMaterialRound(
                              paddingValue: 16.r,
                              child: RichText(
                                text: TextSpan(
                                  style: AppFonts.smRegular.copyWith(
                                    color: Colors.black87,
                                    height: 1.6,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text:
                                          'Saat ini tanaman anda berada di fase \'',
                                    ),
                                    TextSpan(
                                      text: controller.fase.value,
                                      style: AppFonts.smBold,
                                    ),
                                    const TextSpan(
                                      text:
                                          '\' dengan tingkat kepercayaan prediksi sebesar ',
                                    ),
                                    TextSpan(
                                      text:
                                          '"${(controller.confidence.value * 100).toStringAsFixed(1)}%"',
                                      style: AppFonts.smBold,
                                    ),
                                    if (isNoNeed) ...[
                                      const TextSpan(
                                        text:
                                            '. Kandungan unsur hara lahan anda sudah mencukupi, ',
                                      ),
                                      const TextSpan(text: 'sehingga '),
                                      TextSpan(
                                        text: 'tidak perlu penambahan pupuk',
                                        style: AppFonts.smBold,
                                      ),
                                      const TextSpan(text: ' untuk saat ini.'),
                                    ] else ...[
                                      const TextSpan(
                                        text:
                                            '. Anda dianjurkan menambahkan pupuk ',
                                      ),
                                      TextSpan(
                                        text:
                                            '"${controller.recommendation.value}"',
                                        style: AppFonts.smBold,
                                      ),
                                      const TextSpan(text: '.'),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
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

  Widget _npkRow(String label, String symbol, String value) {
    return Row(
      children: [
        SizedBox(
          width: 80.w,
          child: Text(label, style: AppFonts.smRegular),
        ),
        SizedBox(
          width: 40.w,
          child: Text(symbol, style: AppFonts.smRegular),
        ),
        const Spacer(),
        Text(value, style: AppFonts.smSemiBold),
      ],
    );
  }
}
