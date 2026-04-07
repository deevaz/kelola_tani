import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class DialogService {
  static void success({
    required String message,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Ionicons.checkmark_circle,
                color: AppStyle.success,
                size: 60.sp,
              ),
              SizedBox(height: 15.h),
              Text('success'.tr, style: AppFonts.lgBold),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.success,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onConfirm,
                  child: Text('OK', style: TextStyle(color: AppStyle.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Biar user wajib klik OK
    );
  }

  static void showInfo({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Ionicons.information_circle,
                color: AppStyle.primary,
                size: 60.sp,
              ),
              SizedBox(height: 15.h),
              Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onConfirm ?? () => Get.back(),
                  child: Text('OK', style: TextStyle(color: AppStyle.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void error({
    required String title,
    required String message,
    VoidCallback? onConfirm,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Ionicons.close_circle, color: AppStyle.danger, size: 60.sp),
              SizedBox(height: 15.h),
              Text(title == '' ? 'error'.tr : title, style: AppFonts.lgBold),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: onConfirm ?? () => Get.back(),
                  child: Text('OK', style: TextStyle(color: AppStyle.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void confirmation({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Ionicons.help_circle, color: Colors.orange, size: 60.sp),
              SizedBox(height: 15.h),
              Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),
              SizedBox(height: 8.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppFonts.smRegular.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppStyle.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: onCancel ?? () => Get.back(),
                      child: Text(
                        'no'.tr,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: onConfirm,
                      child: Text(
                        'yes'.tr,
                        style: TextStyle(color: AppStyle.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showDetail({
    required String title,
    required Map<String, String> details,
    String? note,
    String? noteLabel,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(title, style: AppFonts.lgBold)),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ...details.entries
                  .map((e) => _itemDetail(e.key, e.value))
                  .toList(),
              if (note != null && note.isNotEmpty) ...[
                SizedBox(height: 15.h),
                Text(
                  noteLabel ?? 'note'.tr,
                  style: AppFonts.mdMedium.copyWith(color: AppStyle.primary),
                ),
                SizedBox(height: 5.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(note, style: AppFonts.smRegular),
                ),
              ],
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyle.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () => Get.back(),
                  child: Text(
                    'close'.tr,
                    style: TextStyle(color: AppStyle.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _itemDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppFonts.xsRegular.copyWith(color: Colors.grey)),
          Text(value, style: AppFonts.mdMedium),
        ],
      ),
    );
  }

  static void input({
    required String title,
    required String hintText,
    required Function(String) onConfirm,
    String? message,
    String? initialValue,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    VoidCallback? onCancel,
  }) {
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppMaterialRound(
          paddingValue: 20.r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppFonts.lgBold, textAlign: TextAlign.center),
              if (message != null) ...[
                SizedBox(height: 8.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppFonts.smRegular.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
              SizedBox(height: 15.h),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                maxLines: maxLines,
                style: AppFonts.mdMedium,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: AppFonts.smRegular.copyWith(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppStyle.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppStyle.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: AppStyle.primary, width: 1.5),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppStyle.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: onCancel ?? () => Get.back(),
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyle.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {
                        onConfirm(controller.text);
                      },
                      child: Text(
                        'save'.tr,
                        style: TextStyle(color: AppStyle.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
