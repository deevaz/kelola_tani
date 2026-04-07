import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_tani/app/core/utils/result_state.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final loginState = Rx<ResultState<void>>(
    const ResultState.initial(),
  ); // nanti isi user model
  bool get isLoading => loginState.value is ResultLoading;

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
