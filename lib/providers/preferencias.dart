import 'dart:ffi';

import 'package:nails_app/models/usuario_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUser {
  static late SharedPreferences _prefs;
  static String _id = "-1";
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static set login(String idCliente) {
    _id = idCliente;
    _prefs.setString('idLogin', _id);
  }

  static String get id {
    return _prefs.getString('idLogin') ?? _id;
  }

  static void delete() {
    _prefs.clear();
  }
}
