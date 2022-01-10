import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nails_app/models/salon.dart';
import 'package:nails_app/models/usuario_models.dart';
import 'package:nails_app/providers/preferencias.dart';
import 'package:nails_app/utilities/general/file-path-provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClienteService extends ChangeNotifier {
  final String _baseUrlBd = 'naillsfinal-default-rtdb.firebaseio.com';
  final String _baseUrlAuth = 'identitytoolkit.googleapis.com';
  final String _fireToken = 'AIzaSyAyW_DeQGp0aWhpXCHqPge3aPqn2AOnZJ8';
  final String _urlIa = '147.182.180.128';
  final DatabaseReference _dbUsuario = FirebaseDatabase.instance.reference();
  Cliente usuario = new Cliente();
  final storage = new FlutterSecureStorage();
  Uint8List image = Uint8List(0);
//PREFERENCIAS DE USUARIO
  //late SharedPreferences prefs;

  //FIREBASE_AUTH
  ClienteService() {
    //this.clienteService();
    //this.cargarUsuarios();
  }
  bool _logueado = false;
  bool _loading = false;
  bool soli = false;
  bool get estaLogueado => _logueado;
  bool get estaSoliOk => soli;
  set estaLogueado(bool valor) {
    this._logueado = valor;
    notifyListeners();
  }

  set soliOk(bool valor) {
    this.soli = valor;
    notifyListeners();
  }

// LOGIN
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
      _dbUsuario
          .child('usuario')
          .child(resultado['localId'])
          .set(usuarioNuevo.toMap());
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
      PrefUser.login = resultado['localId'].toString();
      final url = Uri.https(_baseUrlBd, 'usuario/${resultado['localId']}.json',
          {'auth': await storage.read(key: 'tokenUsuario') ?? ''});
      final resp = await http.get(url);
      final Map<String, dynamic> usuariosMap = json.decode(resp.body);
      print('PRIMER LOGIN WUWU');
      usuario = Cliente.fromMap(usuariosMap);
      print('PRE_ID: ${PrefUser.id}');
    } else {
      if (resultado['error']['message'] == 'EMAIL_NOT_FOUND') {
        return 'El correo no esta registrado';
      } else if (resultado['error']['message'] == 'INVALID_PASSWORD') {
        return 'Contraseña incorrecta';
      }
    }
  }

  Future logout() async {
    PrefUser.delete();
    await storage.delete(key: 'tokenUsuario');
  }

  Future<String> readToken() async {
    String id = await storage.read(key: 'tokenUsuario') ?? '';
    if (id != '') {
      final url = Uri.https(_baseUrlBd, 'usuario/${PrefUser.id}.json',
          {'auth': await storage.read(key: 'tokenUsuario') ?? ''});
      final resp = await http.get(url);
      final Map<String, dynamic> usuariosMap = json.decode(resp.body);
      print('SEGUIMOS LOGUEADOS LOGIN WUWU');
      print('PRE_ID: ${PrefUser.id}');
      if (usuariosMap['error'] == "Auth token is expired") logout();
      usuario = Cliente.fromMap(usuariosMap);
      print(usuariosMap);
    }
    return await storage.read(key: 'tokenUsuario') ?? '';
  }

//CONSUMIENDO APIS
  Future<int?> getSolicitud(Cliente cliente, Uint8List image) async {
    if (image.length > 0) {
      String name = "image0001";
      String extensionFile = ".jpg";
      File imageFile =
          await FilePathProvider.getFile(image, name, extensionFile);
      var filename = imageFile.path;
      final url = Uri.http(_urlIa, '/api/v1/solicitar');
      final req = await http.post(url,
          body: cliente.toJsonSolicitud(),
          headers: {'Content-Type': 'application/json'});
      final resp = json.decode(req.body);
      int id = resp['id'] as int;
      // SEGUNDA PETICION
      final url2 = Uri.http(_urlIa, '/api/v1/solicitar/$id');
      var req2 = http.MultipartRequest('POST', url2);
      //AGREGAR FOTO
      var multipartFile = new http.MultipartFile.fromBytes('image', image,
          filename: filename, contentType: MediaType('multipart', 'form-data'));
      req2.files.add(multipartFile);
      var resp2 = await req2.send();
      final res2 = await resp2.stream.bytesToString();
      Solicitud soli = Solicitud.fromJsonSolicitud(res2);
      return soli.precio;
    }
  }

  Future<List<Salon>> listaDeSalones() async {
    List<Salon> listaSalon = [];
    final url = Uri.http(_urlIa, '/api/v1/salones');
    final respuesta = await http.get(url);
    final Map<String, dynamic> resp = json.decode(respuesta.body);
    for (var nodo in resp['data']) {
      Salon salonActual = Salon.fromMap(nodo);
      listaSalon.add(salonActual);
    }
    return listaSalon;
  }

  String formatFecha(String date) {
    var fecha = date.substring(0, 10);
    var hora = date.substring(11, 19);
    var year = fecha.split('-');
    return '${year[2]}-${year[1]}-${year[0]} $hora';
  }
}
