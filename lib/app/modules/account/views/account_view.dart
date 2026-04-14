import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_button_style.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/auth/controllers/auth_controller.dart';
import 'package:kelola_tani/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_tani/app/shared/widgets/app_button.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 60.h,
            decoration: BoxDecoration(
              color: AppStyle.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.r),
                bottomRight: Radius.circular(30.r),
              ),
            ),
            child: Center(
              child: Text(
                'Akun',
                style: AppFonts.xlSemiBold.copyWith(color: AppStyle.white),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.r),
            child: Column(
              spacing: 15.h,
              children: [
                AppMaterialRound(
                  height: 170.h,
                  width: double.infinity,
                  paddingValue: 15.r,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: controller.photoURL != null
                            ? NetworkImage(controller.photoURL!)
                            : null,
                        child: controller.photoURL == null
                            ? Text(
                                FirebaseAuth.instance.currentUser?.displayName
                                        ?.substring(0, 1)
                                        .toUpperCase() ??
                                    '?',
                                style: const TextStyle(fontSize: 24),
                              )
                            : null,
                      ),
                      const Spacer(),
                      Text(
                        controller.user?.displayName ?? 'User',
                        style: AppFonts.xlBold,
                      ),
                    ],
                  ),
                ),
                AppMaterialRound(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    leading: const Icon(Icons.person),
                    title: Text('Ganti Password', style: AppFonts.lgSemiBold),
                    onTap: () {},
                  ),
                ),
                AppMaterialRound(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    leading: const Icon(Icons.update),
                    title: Text(
                      'Periksa Pembaruan',
                      style: AppFonts.lgSemiBold,
                    ),
                    onTap: () {},
                  ),
                ),
                AppMaterialRound(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    leading: const Icon(Icons.build),
                    title: Text('Perawatan Alat', style: AppFonts.lgSemiBold),
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 5.h),
                AppButton(
                  onTap: () => AuthController.to.logout(),
                  text: 'Keluar',
                  style: AppButtonStyle.rounded15.copyWith(
                    backgroundColor: WidgetStatePropertyAll(AppStyle.danger),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
