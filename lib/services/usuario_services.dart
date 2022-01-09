import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nails_app/models/usuario_models.dart';

class ClienteService extends ChangeNotifier {
  final String _baseUrlBd = 'naillsfinal-default-rtdb.firebaseio.com';
  final String _baseUrlAuth = 'identitytoolkit.googleapis.com';
  final String _fireToken = 'AIzaSyAyW_DeQGp0aWhpXCHqPge3aPqn2AOnZJ8';
  final DatabaseReference _dbUsuario = FirebaseDatabase.instance.reference();
  Cliente usuario = new Cliente();
  final storage = new FlutterSecureStorage();
  bool isLoading = true;
  //FIREBASE_AUTH
  ClienteService() {
    //this.cargarUsuarios();
  }
  bool _logueado = false;
  bool get estaLogueado => _logueado;
  set estaLogueado(bool valor) {
    this._logueado = valor;
    notifyListeners();
  }

  Future<String?> crearUsuario(Cliente usuarioNuevo) async {
    try {
      final Map<String, dynamic> authData = {
        'email': usuarioNuevo.email,
        'password': usuarioNuevo.pass,
        'returnSecureToken': true
      };
      final url =
          Uri.https(_baseUrlAuth, '/v1/accounts:signUp', {'key': _fireToken});
      final resp = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> resultado = json.decode(resp.body);
      print(resultado['localId']);
      print(usuarioNuevo.toMap());
      _dbUsuario.child('usuario').child(resultado['localId']).set(usuarioNuevo.toMap());
      print(resultado['localId']);
      if (resultado.containsKey(resultado['idToken'])) {
        await storage.write(key: 'tokenUsuario', value: resultado['idToken']);
        return null;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'La cuenta ya existe para ese correo electrónico.';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login(String email, String pass) async {
    final Map<String, dynamic> loginData = {
      'email': email,
      'password': pass,
      'returnSecureToken': true
    };
    final url = Uri.https(
        _baseUrlAuth, '/v1/accounts:signInWithPassword', {'key': _fireToken});
    final resp = await http.post(url, body: json.encode(loginData));
    final Map<String, dynamic> resultado = json.decode(resp.body);
    String? id = resultado['idToken'];
    if (id != null) {
      await storage.write(key: 'tokenUsuario', value: resultado['idToken']);
      final url = Uri.https(_baseUrlBd, 'usuario/${resultado['localId']}.json',
          {'auth': await storage.read(key: 'tokenUsuario') ?? ''});
      final resp = await http.get(url);
      final Map<String, dynamic> usuariosMap = json.decode(resp.body);
      print(usuariosMap);
      usuario = Cliente.fromMap(usuariosMap);
    } else {
      if (resultado['error']['message'] == 'EMAIL_NOT_FOUND') {
        return 'El correo no esta registrado';
      } else if (resultado['error']['message'] == 'INVALID_PASSWORD') {
        return 'Contraseña incorrecta';
      }
    }
  }

  Future logout() async {
    await storage.delete(key: 'tokenUsuario');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'tokenUsuario') ?? '';
  }
}
