import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kelola_tani/app/core/utils/result_state.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find<AuthController>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final loginState = Rx<ResultState<User?>>(const ResultInitial());

  bool get isLoading => loginState.value is ResultLoading;

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      Get.offAllNamed('/dashboard');
      loginState.value = ResultSuccess(currentUser);
    }
  }

  Future<void> login({
    required Function(String) onFailed,
    required Function() onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      loginState.value = const ResultLoading();

      await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      loginState.value = ResultSuccess(_auth.currentUser);
      onSuccess();
      Get.offAllNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan';
      if (e.code == 'user-not-found') message = 'Akun tidak ditemukan';
      if (e.code == 'wrong-password') message = 'Password salah';
      if (e.code == 'invalid-email') message = 'Email tidak valid';

      loginState.value = ResultFailed(message);
      onFailed(message);
    }
  }

  Future<void> register({
    required Function(String) onFailed,
    required Function() onSuccess,
  }) async {
    if (!formKey.currentState!.validate()) return;

    try {
      loginState.value = ResultLoading();

      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      await userCredential.user?.updateDisplayName(nameController.text.trim());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
            'name': nameController.text.trim(),
            'username': usernameController.text.trim(),
            'email': emailController.text.trim(),
            'createdAt': FieldValue.serverTimestamp(),
          });

      loginState.value = ResultSuccess(userCredential.user);
      onSuccess();
      Get.offAllNamed('/dashboard');
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan';
      if (e.code == 'email-already-in-use') message = 'Email sudah digunakan';
      if (e.code == 'weak-password') {
        message = 'Password terlalu lemah, minimal 6 karakter';
      }
      if (e.code == 'invalid-email') message = 'Format email tidak valid';

      loginState.value = ResultFailed(message);
      onFailed(message);
    } on FirebaseException catch (e) {
      loginState.value = ResultFailed(e.message ?? 'Gagal menyimpan data');
      onFailed(e.message ?? 'Gagal menyimpan data');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      loginState.value = const ResultLoading();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        loginState.value = const ResultFailed('Login dibatalkan');
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        Get.offAllNamed('/dashboard');
      }

      loginState.value = ResultSuccess(userCredential.user);
      return userCredential.user;
    } catch (e) {
      loginState.value = ResultFailed(e.toString());
      return null;
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    loginState.value = const ResultFailed('Login dibatalkan');
    Get.offAllNamed('/home');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
