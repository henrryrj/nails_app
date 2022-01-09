// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nails_app/screens/rutas.dart';
import 'package:nails_app/services/usuario_services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ClienteService())],
        child: _MyAppState());
  }
}

class _MyAppState extends StatelessWidget {
  final title = "NailsApp";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App de Encuestas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff00838f),
          primaryColorDark: Color(0xff005662),
          primaryColorLight: Color(0xff4fb3bf),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => BienvenidaScreem(),
          'home': (_) => HomePage(title: title),
          'signin': (_) => SigninScreem(),
          'signup': (_) => SignupScreem(),
          'perfil': (_) => Perfil(),
        });
  }
}
