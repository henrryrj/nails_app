import 'package:flutter/material.dart';
import 'package:nails_app/models/usuario_models.dart';

class ClienteProvider extends ChangeNotifier {
  GlobalKey<FormState> keyDelUsuario = new GlobalKey<FormState>();
  Cliente user;
  ClienteProvider(this.user);

  bool _registrado = false;
  bool get estaRegistrado => _registrado;
  set estaRegistrado(bool valor) {
    this._registrado = valor;
    notifyListeners();
  }

  bool esValidadoElFrom() {
    print(user.toMap());
    return keyDelUsuario.currentState?.validate() ?? false;
  }
}
