// lib/controllers/auth_controller.dart
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _isArtist = false.obs;
  final _isLoggedIn = false.obs;

  bool get isArtist => _isArtist.value;
  bool get isLoggedIn => _isLoggedIn.value;

  void setUserType(bool isArtist) {
    _isArtist.value = isArtist;
  }

  void login() {
    _isLoggedIn.value = true;
  }

  void logout() {
    _isLoggedIn.value = false;
  }
}