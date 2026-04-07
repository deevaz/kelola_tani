import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // AppHeader(title: "Akun", height: 200.h),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height - 160.h,
              width: 1.sw,
              decoration: BoxDecoration(
                color: AppStyle.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.r),
                child: Column(children: [

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
