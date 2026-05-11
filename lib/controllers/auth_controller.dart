import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _userName;
  bool _rememberMe = false;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;
  bool get rememberMe => _rememberMe;

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _userName = name;
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    _userName = 'Demo User';
    _isLoggedIn = true;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _userName = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void setRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }
}