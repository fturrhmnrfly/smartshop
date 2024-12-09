import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _email;
  String? _password;
  String? _name; // Tambahkan nama pengguna

  String? get email => _email;
  String? get name => _name; // Getter untuk nama pengguna

  void register(String email, String password, String name) {
    _email = email;
    _password = password;
    _name = name;
    notifyListeners();
  }

  bool login(String email, String password) {
    if (email == _email && password == _password) {
      return true;
    }
    return false;
  }

  void logout() {
    _email = null;
    _password = null;
    _name = null; // Hapus nama pengguna saat logout
    notifyListeners();
  }
}
